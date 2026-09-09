This folder is intentionally empty in the source repository.

The GitHub Actions build workflow (.github/workflows/build-apk.yml)
downloads the offline Vosk speech-recognition model
(vosk-model-small-en-us-0.15.zip, ~40MB) into this folder automatically
before compiling the app, so it never has to be committed to git.

If you are building locally instead of via GitHub Actions, download it
yourself from https://alphacephei.com/vosk/models and place the zip file
(unextracted) in this folder before running `flutter build apk`.
