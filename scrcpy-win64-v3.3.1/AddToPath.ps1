# Set the window title
$Host.UI.RawUI.WindowTitle = "Add Current Directory to SYSTEM PATH"

# Get the current directory
$currentDir = $PSScriptRoot

Write-Host "This script will add the following directory to your SYSTEM Path variable:"
Write-Host $currentDir
Write-Host

# Get the current SYSTEM PATH environment variable from the registry
$systemPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Split the path into an array of directories
$pathDirs = $systemPath -split ';'

# Check if the current directory is already in the PATH
if ($pathDirs -contains $currentDir) {
    Write-Host "The directory is already in your system PATH."
    Write-Host "No changes were made."
} else {
    Write-Host "This directory is not in your system PATH. Adding it now..."

    # Create the new path string
    $newPath = $systemPath + ";" + $currentDir

    # Set the new path permanently for the system
    try {
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")

        # Broadcast a message to notify other windows of the change
        # This can sometimes make the change apply without a full restart
        Add-Type -TypeDefinition 'public class Win32 { [System.Runtime.InteropServices.DllImport("user32.dll")] public static extern int SendMessage(int hWnd, int hMsg, int wParam, string lParam); }'
        [Win32]::SendMessage(0xFFFF, 0x1A, 0, "Environment")

        Write-Host "`nSUCCESS!"
        Write-Host "The directory has been added to your system PATH."
        Write-Host "`nIMPORTANT: Please RESTART any open Command Prompt or PowerShell windows for the change to take effect."
    } catch {
        Write-Host "`nFAILED to add the directory to PATH."
        Write-Host "Please ensure you are running this script with sufficient permissions."
        Write-Host $_.Exception.Message
    }
}

Write-Host
Read-Host -Prompt "Press Enter to exit"
