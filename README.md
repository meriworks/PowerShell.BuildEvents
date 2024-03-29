# Meriworks.PowerShell.BuildEvents
Adds support for triggering PowerShell scripts on build events in Visual Studio.
Instead of using the Build Events of visual studio, this allows you to create PowerShell scripts that is called on different build steps.

* [License](#license)
* [Author](#author)
* [Changelog](#changelog)
* [Documentation](#documentation)

## License
Licensed using the [MIT License](LICENSE.md).

## Author
Developed by [Dan Händevik](mailto:dan@meriworks.se), [Meriworks](http://www.meriworks.se).

## Changelog

### v5.5 - 2021-10-08
* Added [BuildEventsRunnerDisable](#buildeventsrunnerdisable) property
* Fixed paths to PowerShell to work better in vscode/mac

### v5.4 - 2021-04-22
* Removed dll from nuget package

### v5.3.0 - 2020-09-01
* Moved to azure pipelines

### v5.2.0 - 2018-01-03
* Added support for [Extension Variables](#extension-variables)
* Reduced build time by not executing PowerShell runner when no script exists for the current action
* Don't add default scripts in \_msbuild folder if there are any ps1 files present

### v5.1.1 - 2016-10-26
* Fixed error ['copy: Could not find a part of the path' issue (#1)](https://github.com/meriworks/PowerShell.BuildEvents/issues/1)

### v5.1.0 - 2016-10-21
* Added support for [Extension Modules](#extension-modules)

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
The script is a standard PowerShell script (.ps1) that will be invoked in the build process.

In addition to the normal PowerShell environment, extensions and variables are available in the global scope. As per default the following variables are available.

* $solutionDir refers to the path to the solution folder.
* $projectDir refers to the path to the project folder.
* $targetPath is the path to the resulting output target that the project produces.
* $configuration is the name of the current build configuration

### Extension variables
If you would like to add global variables that are available when running a build event, you can do this using an extension variable.

To make BuildEvents automatically import this variable you need to add the following to the csproj file (this will append the path to the module to the list of already added variables).

    <PropertyGroup>
        <BuildEventsRunnerVariables>$(BuildEventsRunnerVariables),myVariable=myValue</BuildEventsRunnerVariables>
    </PropertyGroup>

You can then use this variable in your build script like below.

> Note: No escape sequences for using , or = in the variable value is supported for now.

#### _msbuild\afterbuild.ps1

    echo $myVariable

### Extension modules
If you would like to add PowerShell modules to the scripts without the need to include them you can let the BuildEvents include them for you. To do that, you first need a module. _In this example we store the module in the \_msbuild folder but you can include any module you would like.__

#### _msbuild\ExampleModule.psm1

    function Write-HelloWorld(){
        Write-Host "Hello World!"
    }

To make BuildEvents automatically import this module you need to add the following to the csproj file (this will append the path to the module to the list of already added modules).

    <PropertyGroup>
        <BuildEventsRunnerExtensions>$(BuildEventsRunnerExtensions),$(ProjectDir)_msbuild\ExampleModule.psm1</BuildEventsRunnerExtensions>
    </PropertyGroup>

You can then invoke the functions in the module in any of the BuildEvents scripts, like the example script below.

#### _msbuild\afterbuild.ps1

    Write-HelloWorld


### Optional parameters

#### BuildEventsRunnerDisable
If you would like to disable the BuildEventsRunner, you can add this property to a propertyGroup 

    <PropertyGroup>
        <BuildEventsRunnerDisable>True</BuildEventsRunnerDisable>
    </PropertyGroup>
    
or add it as a parameter to the msbuild argument list

    /p:BuildEventsRunnerDisable=True