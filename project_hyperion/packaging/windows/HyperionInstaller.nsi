!include "MUI2.nsh"

Name "Hyperion Installer"
OutFile "HyperionInstaller.exe"
InstallDir "$PROGRAMFILES\\Hyperion"
RequestExecutionLevel admin

Page directory
Page instfiles

Section "Install"
    SetOutPath "$INSTDIR"
    File "..\\build\\Debug\\ProjectHyperion.exe"
    CreateShortCut "$DESKTOP\\Hyperion.lnk" "$INSTDIR\\ProjectHyperion.exe"
    CreateShortCut "$SMPROGRAMS\\Hyperion\\Hyperion.lnk" "$INSTDIR\\ProjectHyperion.exe"
SectionEnd

Section "Uninstall"
    Delete "$DESKTOP\\Hyperion.lnk"
    Delete "$SMPROGRAMS\\Hyperion\\Hyperion.lnk"
    Delete "$INSTDIR\\ProjectHyperion.exe"
    RMDir "$INSTDIR"
    RMDir "$SMPROGRAMS\\Hyperion"
SectionEnd
