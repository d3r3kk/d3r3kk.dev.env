<# 
  Derek's PowerShell Profile

  Replace whatever is in the $Profile file with this file.

  PS> $d3r3kkProfile = "C:\Path\To\This\File\Powershell.Profile.ps1"
  PS> Copy-Item $d3r3kkProfile $Profile -Force
#>

# Colours and title bar info:
$TitleBar='d3r3kk @ Github'
$ForeColour='Green'
$BackColour='Black'
$UserProfile='dekeeler'

# Where do you want to open your PShell?
$DevRoot='D:\dev\github\d3r3kk'

# Use posh-git to get spanky command line prompts.
$UsePoshGit=$true

# Set this to true to clear the screen on
# enter (and get the background how you like it). 
# Set to false to help debug this script.
$ClearAfterInit=$true 

# Pretty much can leave this next bit alone...


Set-Location $DevRoot

if ([String]::IsNullOrEmpty($UserProfile))
{
	$TheUser = $Env:USERNAME
}
if ([String]::IsNullOrEmpty($TitleBar))
{
	$TitleBar = $TheUser
}

$Host.UI.RawUI.WindowTitle=$TitleBar
$Host.UI.RawUI.BackgroundColor=$BackColour
$Host.UI.RawUI.ForegroundColor=$ForeColour

# To install posh-git on your system, you can do the following:
# Install-Module posh-git -Scope CurrentUser -Repository PSGallery
# ...see https://github.com/dahlbyk/posh-git for further detail.
if ($UsePoshGit)
{
	Import-Module posh-git
}

if ($ClearAfterInit) 
{
	Clear-Host
}
