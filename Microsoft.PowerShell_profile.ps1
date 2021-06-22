Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
# Import-Module (Join-Path (split-path $profile -parent) 'Modules\posh-git')

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git

function shorten-path([string] $path) {
   $loc = $path.Replace($HOME, '~') 
   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 
   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # our theme 
    $cdelim = [ConsoleColor]::White
    $chost = [ConsoleColor]::Green 
    $cloc = [ConsoleColor]::Cyan 

    write-host (shorten-path (pwd).Path) -n -f $cdelim
    Write-VcsStatus

    $Host.UI.RawUI.WindowTitle = Get-Location

    $global:LASTEXITCODE = $realLASTEXITCODE
    "$('>' * ($nestedPromptLevel + 1))"
}

Pop-Location