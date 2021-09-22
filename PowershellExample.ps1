Install - Example Powershell script
##===============================================
## PRE-INSTALLATION
##===============================================
[string]$installPhase = 'Pre-Installation'

## Show Welcome Message, close apps if required, verify there is enough disk space to complete the install, and persist the prompt
Show-InstallationWelcome -CloseApps $appName Acoustic Control,$appName Acquisition Setup,$appName Desktop Neo,$appName Environmental Testing MIMO Random Control,$appName Geometry,$appName Impact Testing,$appName MIMO FRF Testing,
$appName MIMO Normal Modes Testing,$appName MIMO Swept & Stepped Since Testing,$appname Modal Analysis,$appName Multi Reference TPT Processing,$appName Offline Sine Data Reduction,$appName Offline RPM-Extraction,$appName Online Random and Acoustic Reduction,
$appName Operational Modal Analysis,$appName Order-based Modal Analysis,$appName Principal Component Analysis,$appName Process Designer,$appName Random Control,$appname Recording Workbook,$appName Since Control,$appName Signature Data Post-Processing,
$appName Signature Throughout Processing,$appName Single Axis Waveform Replication,$appName Sound Intensity Analysis,$appName Sound Intensity Testing,$appName Spectral Testing,$appName Tracked Since Dwell,$appName Time Data Editor - Advanced,
$appName Time Data Aquisition,$appName Time Waveform Replication,$appName Time Variant Frequency Analysis,TestLab -CheckDiskSpace -PersistPrompt

## Show Progress Message (with the default message)
Show-InstallationProgress

# Show estimated time balloon in minutes
Show-BalloonTip -BalloonTipText $($software.EstimatedRuntimeMins) minutes -BalloonTipTitle 'Estimated Installation Time' -BalloonTipTime '10000'

## Perform Pre-Installation tasks here
Show-InstallationProgress -StatusMessage Installing Simcenter Configuration and Unit System $configVersion...
Execute-MSI -Action 'Install' -Path $dirFilesInstallationsSimcenter Configuration and Unit System $configVersionSimcenter Configuration and Unit System $configVersion Setup.msi -Parameters 'qn'
Show-InstallationProgress -StatusMessage 'Installing Hardware Diagnostics...'
Execute-MSI -Action 'Install' -Path $dirFilesInstallationsSimcenter Hardware DiagnosticsSimcenter Hardware Diagnostics Setup.msi -Parameters 'qn'

##===============================================
## INSTALLATION
##===============================================
[string]$installPhase = 'Installation'

## Perform Installation tasks here
Show-InstallationProgress -StatusMessage Installing $installTitle...
Execute-Process -Path $dirFilesInstallationsSimcenter Testlab setup.exe -Parameters qn  USESERVERCHECK=1 SERVERLIC=26002@license.mtu.edu

##===============================================
## POST-INSTALLATION
##===============================================
[string]$installPhase = 'Post-Installation'

## Perform Post-Installation tasks here
Show-InstallationProgress -StatusMessage 'Removing Desktop Shortcuts...'
Remove-File -Path $envCommonDesktopSimcenter Configuration and Unit System $configVersion.lnk
Remove-File -Path $envCommonDesktopTestlab $appVersion.lnk

Show-InstallationProgress -StatusMessage 'Cleaning Install...'
$shortcuts = @(
    'Testlab Acoustic3D Acoustic Camera.lnk',
    'Testlab AcousticHD Acoustic Camera.lnk',
    'Testlab General ProcessingTime Data Editor Standard.lnk',
    'Testlab General ProcessingTime Signal Calculator.lnk',
    'Testlab Structures AnalysisModal Analysis Lite for Testxpress.lnk',
    'Testlab Structures AnalysisModal Analysis Lite.lnk',
    'Testlab Turbine TestingTurbine Test Recording Manager.lnk'
)
foreach ($shortcut in $shortcuts) {
    Remove-File -Path $envCommonStartMenuProgramsSimcenter Testlab $appVersion$shortcut
}
Remove-Folder -Path $envCommonStartMenuProgramsSimcenter Testlab $appVersion ToolsLicensing

## Display a message at the end of the install
Show-InstallationProgress -StatusMessage Done Installing $installTitle.
