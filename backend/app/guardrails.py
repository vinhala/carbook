from __future__ import annotations

import re
import time
from collections import defaultdict, deque

from app.schemas import AssistantMessageRequest, ScopeClassification

OFF_TOPIC_PATTERNS = {
    "unrelated_topic": [
        "recipe",
        "lasagna",
        "travel",
        "flight",
        "hotel",
        "movie",
        "tv show",
        "election",
        "politics",
        "homework",
        "essay",
        "python script",
        "javascript",
        "leetcode",
        "wedding speech",
    ],
    "generic_automotive": [
        "best sports car",
        "best suv",
        "car under",
        "buy a car",
        "which truck should i buy",
    ],
}

AUTOMOTIVE_KEYWORDS = {
    "oil",
    "coolant",
    "brake",
    "engine",
    "transmission",
    "differential",
    "torque",
    "repair",
    "maintenance",
    "mileage",
    "manual",
    "service",
    "spark",
    "filter",
    "idle",
    "battery",
    "suspension",
    "fluid",
    "diagnose",
    "troubleshoot",
}

COMMON_MAKES = {
    "acura",
    "audi",
    "bmw",
    "chevrolet",
    "dodge",
    "ford",
    "gmc",
    "honda",
    "hyundai",
    "jeep",
    "kia",
    "lexus",
    "mazda",
    "mercedes",
    "mini",
    "mitsubishi",
    "nissan",
    "porsche",
    "subaru",
    "tesla",
    "toyota",
    "volkswagen",
    "volvo",
}


def _tokenize(value: str) -> set[str]:
    return {
        token
        for token in re.split(r"[^a-z0-9]+", value.lower())
        if token and len(token) > 1
    }


def deterministic_scope_check(
    payload: AssistantMessageRequest,
) -> ScopeClassification | None:
    message = payload.message.strip().lower()
    if not message:
        return ScopeClassification(
            allowed=False,
            reason_code="ambiguous_rejected",
            normalized_scope="empty message",
            confidence=1,
        )

    for pattern in OFF_TOPIC_PATTERNS["unrelated_topic"]:
        if pattern in message:
            return ScopeClassification(
                allowed=False,
                reason_code="unrelated_topic",
                normalized_scope=pattern,
                confidence=0.99,
            )

    for pattern in OFF_TOPIC_PATTERNS["generic_automotive"]:
        if pattern in message:
            return ScopeClassification(
                allowed=False,
                reason_code="generic_automotive",
                normalized_scope=pattern,
                confidence=0.95,
            )

    car_terms = {
        payload.profile.make.lower(),
        payload.profile.model.lower(),
        str(payload.profile.year),
        payload.profile.display_name.lower(),
        payload.profile.engine.lower(),
    }
    car_tokens = set().union(*(_tokenize(term) for term in car_terms if term))
    strong_terms = set(car_tokens)
    weak_terms: set[str] = set()

    for item in payload.maintenance_items:
        weak_terms.update(_tokenize(item.title))
        if item.description:
            weak_terms.update(_tokenize(item.description))

    for repair in payload.repairs:
        weak_terms.update(_tokenize(repair.title))
        if repair.description:
            weak_terms.update(_tokenize(repair.description))
        weak_terms.update(_tokenize(repair.area))

    for manual in payload.manuals:
        strong_terms.update(_tokenize(manual.original_name))

    message_tokens = _tokenize(message)
    other_make_mentions = (COMMON_MAKES & message_tokens) - {
        payload.profile.make.lower()
    }
    if other_make_mentions:
        return ScopeClassification(
            allowed=False,
            reason_code="unrelated_topic",
            normalized_scope=f"other vehicle reference: {sorted(other_make_mentions)[0]}",
            confidence=0.92,
        )

    if (
        {"my", "car"} <= message_tokens
        or {"this", "car"} <= message_tokens
        or {"my", "vehicle"} <= message_tokens
        or {"this", "vehicle"} <= message_tokens
    ):
        return ScopeClassification(
            allowed=True,
            reason_code="about_active_car",
            normalized_scope="explicit active vehicle reference",
            confidence=0.88,
        )

    if strong_terms & message_tokens:
        return ScopeClassification(
            allowed=True,
            reason_code="about_active_car",
            normalized_scope="matched active car context",
            confidence=0.94,
        )

    if payload.conversation_id and (AUTOMOTIVE_KEYWORDS | weak_terms) & message_tokens:
        return ScopeClassification(
            allowed=True,
            reason_code="about_active_car",
            normalized_scope="in-conversation automotive follow-up",
            confidence=0.76,
        )

    if AUTOMOTIVE_KEYWORDS & message_tokens:
        return None

    return ScopeClassification(
        allowed=False,
        reason_code="unrelated_topic",
        normalized_scope="no active car linkage",
        confidence=0.9,
    )


class InMemoryRateLimiter:
    def __init__(self, limit: int, window_seconds: int) -> None:
        self._limit = limit
        self._window_seconds = window_seconds
        self._buckets: dict[str, deque[float]] = defaultdict(deque)

    def check(self, key: str) -> bool:
        now = time.monotonic()
        bucket = self._buckets[key]
        while bucket and now - bucket[0] > self._window_seconds:
            bucket.popleft()
        if len(bucket) >= self._limit:
            return False
        bucket.append(now)
        return True
