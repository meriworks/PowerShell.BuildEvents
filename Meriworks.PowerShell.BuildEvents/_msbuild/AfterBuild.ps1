param([string] $solutionDir, [string] $projectDir, [string] $targetPath)

#Add powershell statements that should be executed after the build
. (Join-Path $projectDir "_msbuild/Meriworks.PowerShell.Sign/Functions.ps1")

Write-Host "Signing scripts"
SignScript (join-path $projectDir "nuspec/tools/install.ps1")
SignScriptsInFolder (join-path $projectDir "nuspec/content/_msbuild/Meriworks.PowerShell.BuildEvents")