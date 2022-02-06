# Software-game-complex

## Custom targets

* `AdminTranslateAndRun` - Gets text to update, compiles translations to binary format and runs admin app
* `AdminTranslationsUpdate` - Gets text to update. You can then edit *.ts files in resources/i18n
* `AdminTranslationsRelease` - Compiles translations to binary format and generates *.qm files in resources/i18n

## About running on Windows (not final)
- Install Craft (**CHOOSE MINGW WHILE INSTALLING**) https://community.kde.org/Guidelines_and_HOWTOs/Build_from_source/Windows
- Open craft and run following commands:
```shell
craft kirigami
craft ki18n
craft kcoreaddons
craft breeze-icons
craft qqc2-desktop-style
craft sonnet
craft extra-cmake-modules
```
- Modify env variables: 
  - Add `CMAKE_PREFIX_PATH` pointing to QT 5.15 built with mingw and to Craft root - required for building
  - Modify `Path`: add `<CraftRoot>\bin` (e.g. `C:\CraftRoot\bin`) - that the actual QT path that will be used at runtime
- Copy `data` directory from `<CraftRoot>\build\kde\frameworks\tier1\breeze-icons\image-RelWithDebInfo-5.90.0\bin` to the dir with executable
- Copy `<CraftRoot>\plugins\kf5\kirigami` to `<YourExecutableParentDir>\kf5\kirigami`
- Copy `<CraftRoot>\qml\org\kde\qqc2desktopstyle` to `<YourExecutableParentDir>\org\kde` AND ENSURE DLL NAME IS `qqc2desktopstyleplugin.dll`
- Copy `<CraftRoot>\build\kde\frameworks\tier1\sonnet\image-RelWithDebInfo-5.90.0\qml\org\kde\sonnet` to `<YourExecutableParentDir>\org\kde` AND ENSURE DLL NAME IS `sonnetquickplugin.dll`