[CmdLetBinding()]
Param(
    [Parameter(Mandatory)][string]$VscodeWorkspaceFolder,
    [Parameter(Mandatory)][string]$OmnisharpBinaryFolder
)

if(-not (Test-Path $VscodeWorkspaceFolder))
{
    throw "Could not find folder $VscodeWorkspaceFolder"
}

$OmnisharpExecutable = "$OmnisharpBinaryFolder$(if($IsLinux) { "Omnisharp" } else { "Omnisharp.exe" })"
$tempFolder = "$PSScriptRoot/temp/omnisharp-binaries/"

while($true)
{
    if(-not (Test-Path $OmnisharpBinaryFolder) -or -not (Test-Path $OmnisharpExecutable))
    {
        throw "Could not find path for omnisharp binaries folder $OmnisharpBinaryFolder or omnisharp executable $OmnisharpExecutable"
    }

    if(Test-Path $tempFolder)
    {
        Remove-Item $tempFolder -ErrorAction Continue -Recurse -Force
    }

    Copy-Item $OmnisharpBinaryFolder $PSScriptRoot/temp/omnisharp-binaries/ -recurse -force

    code

    Read-Host "asd"
}