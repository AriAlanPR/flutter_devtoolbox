### Description

This pull request resolves critical build and compilation failures on recent versions of macOS and Flutter. The project was previously unbuildable due to breaking changes in its dependencies, most notably `macos_ui`.

This update refactors the user interface to adopt modern APIs, fixes configuration issues in the native macOS project, and ensures the application compiles and runs successfully.

### Problem

The project would not compile due to:
1.  Use of deprecated widgets and properties from an older version of the `macos_ui` package (`titleBar`, `buttonSize`).
2.  Outdated exception handling for the `dart_jsonwebtoken` package.
3.  An incorrect minimum macOS deployment target, causing conflicts with updated plugins.

### Solution

- **Dependency Modernization**: Updated all Flutter dependencies to their latest stable versions.
- **UI Refactoring**: 
  - Replaced the deprecated `titleBar` with `toolBar` across all screens.
  - Updated all `PushButton` widgets to use `controlSize` instead of `buttonSize`.
  - Standardized `StatefulWidget` creation to align with modern Flutter practices.
- **macOS Project Configuration**:
  - Updated the `Podfile` and `project.pbxproj` to set the `MACOSX_DEPLOYMENT_TARGET` to `10.14.6`, resolving build-time dependency conflicts.
- **Bug Fixes**:
  - Corrected the exception names in the JWT Debugger tool to match the new `dart_jsonwebtoken` API.

### How to Test

1.  Clone the branch.
2.  Run `flutter pub get`.
3.  Run `flutter build macos --release`.
4.  The application should build successfully.

This PR makes the project usable again for developers on current systems and ensures its long-term maintainability.
