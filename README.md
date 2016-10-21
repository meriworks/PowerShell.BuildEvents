# Meriworks.PowerShell.BuildEvents
Adds support for triggering PowerShell scripts on build events in Visual Studio.
Instead of using the Build Events of visual studio, this allows you to create PowerShell scripts that is called on different build steps.

* [License](#license)
* [Author](#author)
* [Changelog](#changelog)
* [Documentation](#documentation)

<a name="license"></a>
## License
Project is licensed using the [MIT License](LICENSE.md).

<a name="author"></a>
## Author
Package is developed by [Dan Händevik](mailto:dan@meriworks.se), [Meriworks](http://www.meriworks.se).

<a name="changelog"></a>
## Changelog

### v5.0.2 - 2016-10-21
* Removed unused dll from nupkg file
* Removed scripts and readme from project

### v5.0.1 - 2016-10-17
* Minor changes in nuspec, license and documentation

### v5.0.0 - 2016-10-17
* Initial release

<a name="documentation"></a>
## Documentation
When the Meriworks.PowerShell.BuildEvents nuget package is referred to the project, it will scan the _msbuild folder for PowerShell scripts and execute them according to their name.

### Actions
We support three actions that can be hooked into; **Build**, **Compile** and **Publish**. 

To hook into an action, decide if you need to hook **Before** or **After** the action.

Name the script accordingly; ie. **BeforeBuild.ps1** will be executed before the build action.

### Configurations
You can also specify a script that only will be triggered during a specific configuration by suffixing the configuration name to the script name.
ie. **AfterBuildRelease.ps1** will only be triggered after a release build. 

### The scripts
The script is a powershell script (.ps1) that will be invoked with four parameters,

    param([string] $solutionDir, [string] $projectDir, [string] $targetPath, [string] $configuration)

where the parameters are as follows.

* $solutionDir refers to the path to the solution folder.
* $projectDir refers to the path to the project folder.
* $targetPath is the path to the resulting output target that the project produces.
* $configuration is the name of the current build configuration


