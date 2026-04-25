# carbook
Monorepo for the Carbook mobile app and its minimal AI relay backend.

## Layout

- `mobile/`: Flutter application for vehicle profiles, maintenance, repairs, manuals, and the AI assistant UI
- `backend/`: FastAPI relay that keeps the OpenAI API key server-side and powers manual ingestion, guarded chat, and AI schedule suggestions

## Local Development

### Mobile

```bash
cd mobile
flutter pub get
flutter run
```

### Backend

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -e .[dev]
uvicorn app.main:app --reload
```

Required backend environment variables:

- `OPENAI_API_KEY`
- `OPENAI_MODEL` (optional, defaults to `gpt-5.4-mini`)
- `CARBOOK_DATABASE_URL` (optional, defaults to local SQLite)
- `CARBOOK_ALLOWED_ORIGIN` (optional, defaults to `*`)

The Flutter app can target the backend with:

```bash
cd mobile
flutter run --dart-define=CARBOOK_API_BASE_URL=http://localhost:8000
```

## GitHub Actions

The repository includes two GitHub Actions workflows:

- `ci.yml` runs Flutter tests from `mobile/` and backend tests from `backend/`.
- `release.yml` runs on tags matching `v*` and `preview*`.

Release tags are interpreted as follows:

- `vX.Y.Z` publishes a production release to App Store Connect and the Play Store production track.
- `previewX.Y.Z` or `preview-X.Y.Z` publishes a beta release to TestFlight and the Play Store internal track.

The release workflow fails fast unless the tag version exactly matches the marketing version in `mobile/pubspec.yaml`.

### Required GitHub Secrets

Android:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`

iOS:

- `IOS_DIST_CERT_P12_BASE64`
- `IOS_DIST_CERT_PASSWORD`
- `IOS_PROVISIONING_PROFILE_BASE64`
- `IOS_PROVISIONING_PROFILE_NAME`
- `APPLE_TEAM_ID`
- `APPSTORE_CONNECT_KEY_ID`
- `APPSTORE_CONNECT_ISSUER_ID`
- `APPSTORE_CONNECT_PRIVATE_KEY`

### Environment Setup

Create GitHub environments named `production` and `preview` and attach the corresponding store credentials there if you want approvals or environment-scoped secrets on release jobs.

For local release builds, Android signing can come from `mobile/android/key.properties`, and iOS can override release signing with an untracked `mobile/ios/Flutter/Release-secrets.xcconfig`.
