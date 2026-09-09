# SpeakRight English (native app source)

Module 1: Conversation — 10 topics, fully offline, no LLM, no server.

## What's in this repo

- `lib/` — the entire Dart/Flutter app (screens, content, services).
- `pubspec.yaml` — dependencies: `flutter_tts` (offline Teacher voice) and
  `vosk_flutter_2` (offline, on-device speech recognition — no internet,
  no API key, no LLM, ever).
- `assets/models/` — empty on purpose. The build workflow downloads the
  ~40MB offline speech model here automatically before compiling.
- `.github/workflows/build-apk.yml` — builds a ready-to-install `.apk`
  automatically, for free, using GitHub's own servers (this project's own
  sandbox cannot reach the Android SDK's servers, so the actual Android
  compile step always happens on GitHub Actions instead).

## Getting the APK

Push this repo to GitHub (or upload the files through the GitHub website),
open the **Actions** tab, wait for the **Build SpeakRight APK** workflow to
finish, then download the `SpeakRight-apk` artifact. See the full guide
that came with this file for exact click-by-click steps.

## Why the app looks different from a plain web build

This is a genuine native Android app, not a wrapped website. That's what
makes the speech recognition and scoring work with the phone in airplane
mode: the ~40MB voice model ships inside the `.apk` itself and never talks
to a server.
