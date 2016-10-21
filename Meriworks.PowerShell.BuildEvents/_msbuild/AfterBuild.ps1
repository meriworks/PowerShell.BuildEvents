param([string] $solutionDir, [string] $projectDir, [string] $targetPath)

Write-HelloWorld

Write-Host "Signing scripts"
SignScript (join-path $projectDir "nuspec/tools/install.ps1")
SignScript (join-path $projectDir "nuspec/tools/runner.ps1")