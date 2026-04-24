# carbook
Mobile application for keeping track of car maintenance, spare parts, documenting procedures and getting AI based guidance

## GitHub Actions

The repository includes two GitHub Actions workflows:

- `ci.yml` runs on every push to `main` and executes `flutter test test`.
- `release.yml` runs on tags matching `v*` and `preview*`.

Release tags are interpreted as follows:

- `vX.Y.Z` publishes a production release to App Store Connect and the Play Store production track.
- `previewX.Y.Z` or `preview-X.Y.Z` publishes a beta release to TestFlight and the Play Store internal track.

The release workflow fails fast unless the tag version exactly matches the marketing version in `pubspec.yaml`.

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

For local release builds, Android signing can come from `android/key.properties`, and iOS can override release signing with an untracked `ios/Flutter/Release-secrets.xcconfig`.
