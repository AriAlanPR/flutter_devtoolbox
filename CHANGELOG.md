# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Resolved numerous compilation and linter errors across all tool screens caused by major dependency upgrades (`macos_ui`, `dart_jsonwebtoken`, etc.).
- Corrected usage of deprecated `macos_ui` widgets:
  - Replaced `titleBar` with the new `toolBar` property in `MacosScaffold`.
  - Updated `PushButton` to use `controlSize` instead of the old `buttonSize` property.
- Fixed incorrect exception class names in the JWT Debugger tool (`JWTExpiredError` -> `JWTExpiredException`, `JWTError` -> `JWTException`) to match the updated `dart_jsonwebtoken` package API.
- Standardized the `createState` method signature in all screen widgets for better compatibility with modern Flutter versions.
- Aligned the minimum macOS deployment target to `10.14.6` in both the `Podfile` and the main Xcode project configuration (`project.pbxproj`) to resolve build failures caused by updated plugins.
