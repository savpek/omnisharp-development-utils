[CmdLetBinding()]
Param(
    [Parameter(Mandatory)][string]$VscodeWorkspaceFolder,
    [Parameter(Mandatory)][string]$OmnisharpBinaryFolder
)

if(-not (Test-Path $VscodeWorkspaceFolder))
{
    throw "Could not find folder $VscodeWorkspaceFolder"
}

$omnisharpExecutable = "$OmnisharpBinaryFolder$(if($IsLinux) { "Omnisharp" } else { "Omnisharp.exe" })"
$tempOmnisharpBinaries = "$PSScriptRoot/temp/omnisharp-binaries/"
$tempOmnisharpExecutable = "$tempOmnisharpBinaries$(if($IsLinux) { "Omnisharp" } else { "Omnisharp.exe" })"
$tempUserSettings = "$PSScriptRoot/temp/user-profile/User/settings.json"
$tempUserProfileFolder = "$PSScriptRoot/temp/user-profile/"
$tempExtensions = "$PSScriptRoot/temp/extensions/"

$userSettingsTemplate = Get-Content -Raw $PSScriptRoot/vscodeSettingsTemplate.json | ConvertFrom-Json -AsHashtable

while($true)
{
    if(-not (Test-Path $OmnisharpBinaryFolder) -or -not (Test-Path $omnisharpExecutable))
    {
        throw "Could not find path for omnisharp binaries folder $OmnisharpBinaryFolder or omnisharp executable $omnisharpExecutable"
    }

    if(Test-Path $tempOmnisharpBinaries)
    {
        Remove-Item $tempOmnisharpBinaries -ErrorAction Continue -Recurse -Force
    }

    Copy-Item $OmnisharpBinaryFolder $tempOmnisharpBinaries -recurse -force

    if(-not (Test-Path ([System.IO.Path]::GetDirectoryName($tempUserSettings))))
    {
        New-Item -ItemType Directory ([System.IO.Path]::GetDirectoryName($tempUserSettings)) -Force
    }

    $userSettingsTemplate["omnisharp.path"] = (Resolve-Path $tempOmnisharpExecutable).Path
    $userSettingsTemplate | ConvertTo-Json | Set-Content $tempUserSettings -Force

    code --install-extension ms-vscode.csharp --extensions-dir $tempExtensions
    code --wait --new-window --extensions-dir $tempExtensions --user-data-dir $tempUserProfileFolder $VscodeWorkspaceFolder
}