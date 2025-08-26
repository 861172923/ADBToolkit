# ADB & Scrcpy Toolkit

English | [中文](README.md)

This is a powerful Android device management toolkit that seamlessly integrates commonly used ADB (Android Debug Bridge) commands with high-performance Scrcpy screen mirroring tools through a simple menu interface. Whether you're a developer, tester, or advanced user, this script can greatly improve your work efficiency.

---

## Core Features

*   **Device Management**: Easily view, restart, and enter special modes (Recovery/Bootloader).
*   **App Management**: Quickly install, uninstall, start, and stop applications.
*   **Wireless Connection**: Connect and manage your devices without data cables.
*   **Screen Operations**: One-click screenshots and screen recording, automatically saved to your computer.
*   **Advanced Screen Mirroring (Scrcpy)**: Integrated powerful Scrcpy providing low-latency, high-quality screen mirroring and control, with advanced adaptation features for special devices like AR glasses.
*   **Log Tools**: View and clear device logs for debugging.

---

## Pre-Use Preparation

1.  **Install ADB**:
    *   Ensure you have Android SDK Platform Tools installed, and the path containing `adb.exe` has been added to your system's `PATH` environment variable.

2.  **Install Scrcpy**:
    *   Ensure you have downloaded Scrcpy (this project includes the `scrcpy-win64-v3.3.1` folder).
    *   Add the path containing `scrcpy.exe` (e.g., `E:\Tool\Adb Tool\scrcpy-win64-v3.3.1`) to your system's `PATH` environment variable so the script can find it.

3.  **Enable USB Debugging on Android Device**:
    *   Go to `Settings` > `About Phone`.
    *   Tap "Build Number" 7 times until you see "You are now a developer".
    *   Go back to the previous menu, enter `System & Updates` > `Developer Options`.
    *   Turn on "USB Debugging".

---

## How to Use

1.  Connect your Android device to your computer via USB cable.
2.  Double-click to run the `adb_tool.bat` file.
3.  According to the menu displayed on screen, enter the corresponding number and press Enter to execute the corresponding function.

---

## Feature Details

### Main Menu

*   **1. View Devices**: List all connected devices and their status.
*   **2. Install APK**: Prompt you to enter the complete path of the APK file and install it to the device.
*   **3. Wireless Connection**: Enter the wireless connection submenu, where you can enable TCP mode or connect to devices via IP address. **First-time users please follow the guided operation to successfully connect**.
*   **4. Scrcpy Advanced Screen Mirroring**: Enter the powerful Scrcpy function menu (see details below).
*   **5. Screenshot**: Capture the current device screen and automatically save to the `screenshot` folder.
    *   Automatically creates `screenshot` folder (if it doesn't exist)
    *   Supports custom filenames, automatically adds `.png` extension
    *   File save path: `screenshot\filename.png`
*   **6. Screen Recording**: Use Scrcpy to record device screen, automatically save to the `scrcpy_record` folder.
    *   Automatically creates `scrcpy_record` folder (if it doesn't exist)
    *   Supports custom filenames, automatically adds `.mp4` extension
    *   File save path: `scrcpy_record\filename.mp4`
    *   Uses Scrcpy engine for high-quality recording
*   **7. Uninstall App**: Prompt you to enter the app package name (e.g., `com.example.app`) and uninstall it.
*   **8. Restart Device**: Restart your Android device.
*   **9. Restart to Recovery**: Restart the device to Recovery mode.
*   **10. Restart to Bootloader**: Restart the device to Bootloader mode.
*   **11. View Logs**: Provides three modes to view device logs (all/real-time/errors only).
*   **12. Clear Logs**: Clear cached logs on the device.
*   **13. Get Serial Number**: Display the device's unique serial number.
*   **14. View Device Status**: Display device connection status and model information.
*   **15. Start App**: Start an app based on package name and optional Activity name.
*   **16. Stop App**: Force stop a running app.
*   **17. Get IP Address**: Display the device's WLAN IP address for wireless connection.
*   **18. Disconnect**: Enter the disconnect submenu, where you can choose to disconnect all devices or specific devices.

## Usage Method

1. Ensure Android SDK is installed and ADB environment is configured
2. Double-click to run the `adb_tool.bat` file
3. Select the corresponding function according to the menu prompts
4. Enter necessary information as prompted

## File Description

- `adb_tool.bat` - Main program file (Chinese interface, encoding issues fixed)
- `README.md` - Detailed usage instructions

### Scrcpy Advanced Screen Mirroring (Main Menu Option 4)

*   **1. Start Default Mirror**: Start Scrcpy with default settings, allowing full device control.
*   **2. Start Read-Only Mode**: Display screen only, computer mouse and keyboard cannot control the device.
*   **3. Record Screen**: No mirroring window displayed, directly record screen operations as `scrcpy_record.mkv` file.
*   **4. List Available Displays**: Display all available displays on the device and their IDs (for external displays or AR glasses).
*   **5. Low Quality (Fluent)**: Start with lower quality and resolution, providing smoother experience when wireless connection is unstable.
*   **6. Specify Display**: Core advanced feature, designed for multi-screen or special devices.
    1.  First, it will list all available display IDs.
    2.  After you input the display ID to show, you'll enter **Crop Mode Selection**:
        *   **1 (Auto Split)**: You just need to press `1`, the script will automatically get the total resolution of that display and automatically calculate half the width for cropping. This is a "one-click" solution designed for AR glasses and other left-right split screen devices.
        *   **2 (Manual Input)**: You can manually input complete crop parameters (`width:height:X:Y`).
        *   **0 (No)**: No cropping, display the complete screen of that display.

---

## File Structure

*   `adb_tool.bat`: Main program of the toolkit.
*   `scrcpy-win64-v3.3.1/`: Contains Scrcpy open-source screen mirroring tool.
    *   `AddToPath.bat`: Environment variable auto-configuration script (requires administrator privileges to run).
*   `README.md`: This instruction file.

### Auto-Created Folders

*   `screenshot/`: Screenshot file storage folder (auto-created)
    *   Stores all screenshot image files
    *   Format: PNG image files
    *   Example: `screenshot\my_screenshot.png`
*   `scrcpy_record/`: Screen recording file storage folder (auto-created)
    *   Stores all screen recording video files
    *   Format: MP4 video files
    *   Example: `scrcpy_record\my_recording.mp4`

---

## Pre-Use Preparation

1.  **Install ADB**:
    *   Ensure you have Android SDK Platform Tools installed, and the path containing `adb.exe` has been added to your system's `PATH` environment variable.

2.  **Install Scrcpy**:
    *   Ensure you have downloaded Scrcpy (this project includes the `scrcpy-win64-v3.3.1` folder).
    *   **Auto-configure environment variables**: Run `scrcpy-win64-v3.3.1\AddToPath.bat` script as administrator, it will automatically add Scrcpy to your system's `PATH` environment variable.
    *   **Manual configuration**: If auto-configuration fails, manually add the path containing `scrcpy.exe` (e.g., `E:\Tool\Adb Tool\scrcpy-win64-v3.3.1`) to your system's `PATH` environment variable.

3.  **Enable USB Debugging on Android Device**:
    *   Go to `Settings` > `About Phone`.
    *   Tap "Build Number" 7 times until you see "You are now a developer".
    *   Go back to the previous menu, enter `System & Updates` > `Developer Options`.
    *   Turn on "USB Debugging".

---

## How to Use

1.  Connect your Android device to your computer via USB cable.
2.  Double-click to run the `adb_tool.bat` file.
3.  According to the menu displayed on screen, enter the corresponding number and press Enter to execute the corresponding function.

---

## Important Notes

1. **Permission Requirements**: Some operations require device root permissions
2. **Network Connection**: Wireless connection function requires device and computer to be on the same network
3. **File Path**: Use complete path when installing APK
4. **Package Name Format**: App package names are usually in `com.example.appname` format
5. **Scrcpy Environment**: Ensure scrcpy.exe is added to system PATH environment variable
6. **File Management**:
    *   Screenshot and screen recording functions automatically create corresponding folders
    *   Screenshot files are saved in the `screenshot` folder
    *   Screen recording files are saved in the `scrcpy_record` folder
    *   Supports custom filenames, program automatically adds correct file extensions

---

## FAQ

### Q: Device cannot connect?
A: Check if USB debugging is enabled and drivers are correctly installed

### Q: Wireless connection fails?
A: Ensure device and computer are on the same WiFi network and device IP address is correct

### Q: Scrcpy functions cannot be used?
A: Check if scrcpy is correctly installed and added to PATH environment variable

### Q: AR glasses screen mirroring display abnormal?
A: Use "Auto Split" mode in "Specify Display" function, optimized for AR devices

### Q: Where are screenshot files saved?
A: Screenshot files are automatically saved in the `screenshot` folder, program automatically creates this folder

### Q: Where are screen recording files saved?
A: Screen recording files are automatically saved in the `scrcpy_record` folder, program automatically creates this folder

### Q: How to customize screenshot/screen recording filenames?
A: When executing the function, you'll be prompted to input filename, program automatically adds correct file extensions (.png/.mp4)

### Q: Will missing folders affect function usage?
A: No, program automatically checks and creates required folders

---

## System Requirements

- Windows 7/8/10/11
- Android SDK Platform Tools
- Android device supporting ADB
- Scrcpy 3.3.1+ (included)

---

## Acknowledgments

*   **Original Script Author**: Bilibili: Cool灬浩 (https://space.bilibili.com/228962838)
*   **Scrcpy Open Source Project**: Genymobile (https://github.com/Genymobile/scrcpy) 