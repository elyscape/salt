Function Install-SaltNuGet {
        <#
    .SYNOPSIS
    Installs NuGet from the web.
    .DESCRIPTION
    Checks that NuGet is installed in given folder location. If it isn't it is downloaded from the web.
    .PARAMETER WorkingFolder
    Location that Nuget.exe is/isn't.
    .INPUTS
    N/A
    .OUTPUTS
    NugetExe: the path to Nuget, irrespective of whether it was downloaded or already existed.
    .EXAMPLE
    $NuGetPath = Install-NuGet -WorkingFolder $PsScriptRoot
    .NOTES
      N/A
    #>
        [CmdletBinding()]
        param
        (
            [Parameter(Mandatory = $true)]
            [string] $WorkingFolder
        )
        $NuGetInstallUri = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
        Write-Verbose "Working Folder   : $WorkingFolder" -Verbose
        $NugetExe = $("$WorkingFolder\nuget.exe")
        if (-not (Test-Path $NugetExe)) {
            Write-Verbose "Cannot find nuget at path $WorkingFolder\nuget.exe" -Verbose
            $sourceNugetExe = $NuGetInstallUri
            Write-Verbose "$sourceNugetExe -OutFile $NugetExe" -Verbose
            Invoke-WebRequest $sourceNugetExe -OutFile "$NugetExe"
            if (-not (Test-Path $NugetExe)) { 
                Throw "It appears that the nuget download hasn't worked."
            }
            Else {
                Write-Verbose "Nuget Downloaded!" -Verbose
            }
        }
        Return $NugetExe
    }