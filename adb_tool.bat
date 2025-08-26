@echo off
chcp 65001 >nul
title ADB 工具
color 0A

:menu
cls
echo ========================================
echo            ADB 工具
echo            B站：Cool灬浩
echo            欢迎关注三连
echo ========================================
echo.
echo 请选择操作:
echo.
echo 1.  查看设备
echo 2.  安装APK
echo 3.  无线连接
echo 4.  Scrcpy 高级投屏
echo 5.  卸载应用
echo 6.  重启设备
echo 7.  重启到Recovery
echo 8.  重启到Bootloader
echo 9.  截屏
echo 10. 录屏
echo 11. 查看日志
echo 12. 清除日志
echo 13. 获取序列号
echo 14. View device status
echo 15. Start app
echo 16. 停止应用
echo 17. 获取IP地址
echo 18. 断开连接
echo 0.  退出
echo.
echo ========================================
echo.

set /p choice=请输入选项 (0-18):

if "%choice%"=="0" goto exit
if "%choice%"=="1" goto devices
if "%choice%"=="2" goto install_apk
if "%choice%"=="3" goto wireless_connect
if "%choice%"=="4" goto scrcpy_menu
if "%choice%"=="5" goto uninstall_app
if "%choice%"=="6" goto reboot
if "%choice%"=="7" goto reboot_recovery
if "%choice%"=="8" goto reboot_bootloader
if "%choice%"=="9" goto screenshot
if "%choice%"=="10" goto screen_record
if "%choice%"=="11" goto view_logs
if "%choice%"=="12" goto clear_logs
if "%choice%"=="13" goto get_serial
if "%choice%"=="14" goto device_status
if "%choice%"=="15" goto start_app
if "%choice%"=="16" goto stop_app
if "%choice%"=="17" goto get_ip
if "%choice%"=="18" goto disconnect_wireless
goto menu


:devices
cls
echo 查看已连接设备...
echo.
adb devices
echo.
pause
goto menu

:install_apk
cls
echo 安装APK
echo.
set /p apk_path=请输入APK文件路径:
if "%apk_path%"=="" goto install_apk
echo 正在安装APK...
adb install "%apk_path%"
echo.
pause
goto menu

:uninstall_app
cls
echo 卸载应用
echo.
set /p package_name=请输入应用包名:
if "%package_name%"=="" goto uninstall_app
echo 正在卸载应用...
adb uninstall "%package_name%"
echo.
pause
goto menu

:reboot
cls
echo 正在重启设备...
adb reboot
echo 设备正在重启...
echo.
pause
goto menu

:reboot_recovery
cls
echo 正在重启到Recovery模式...
adb reboot recovery
echo 设备正在重启到Recovery...
echo.
pause
goto menu

:reboot_bootloader
cls
echo 正在重启到Bootloader...
adb reboot bootloader
echo 设备正在重启到Bootloader...
echo.
pause
goto menu

:screenshot
cls
echo 截屏功能
echo.
set /p filename=请输入截图文件名 (默认: screenshot.png):
if "%filename%"=="" set filename=screenshot.png
echo 正在截屏...
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png "%filename%"
adb shell rm /sdcard/screenshot.png
echo 截图已保存为: %filename%
echo.
pause
goto menu

:screen_record
cls
echo 录屏功能
echo.
echo 1. 开始录制
echo 2. 停止
echo.
set /p record_choice=请选择操作 (1-2):
if "%record_choice%"=="1" goto start_record
if "%record_choice%"=="2" goto stop_record
goto screen_record

:start_record
set /p record_filename=请输入录制文件名 (默认: screen_record.mp4):
if "%record_filename%"=="" set record_filename=screen_record.mp4

echo 正在检查设备是否支持录屏...
for /f "tokens=*" %%a in ('adb shell "command -v screenrecord"') do (
    set "screenrecord_path=%%a"
)

if not defined screenrecord_path (
    echo.
    echo 错误: 您的设备不支持录屏功能 (找不到 screenrecord 命令).
    echo 这通常发生在 Android 4.4 之前的版本.
    echo.
    pause
    goto screen_record
)

echo 正在开始录制...
adb shell screenrecord /sdcard/screen_record.mp4 &
echo 录制已开始，按任意键停止...
pause
goto stop_record

:stop_record
echo 正在停止录制...
adb shell pkill -l SIGINT screenrecord
timeout /t 3 /nobreak >nul
echo 正在下载录制文件...
adb pull /sdcard/screen_record.mp4 "%record_filename%"
adb shell rm /sdcard/screen_record.mp4
echo 录制文件已保存为: %record_filename%
echo.
pause
goto menu

:view_logs
cls
echo 查看日志
echo.
echo 1. 查看所有日志
echo 2. 实时查看日志
echo 3. 查看错误日志
echo.
set /p log_choice=请选择日志类型 (1-3):
if "%log_choice%"=="1" (
    echo 正在查看所有日志...
    adb logcat
)
if "%log_choice%"=="2" (
    echo 正在实时查看日志...
    adb logcat -f -
)
if "%log_choice%"=="3" (
    echo 正在查看错误日志...
    adb logcat *:E
)
echo.
pause
goto menu

:clear_logs
cls
echo 正在清除日志...
adb logcat -c
echo 日志已清除
echo.
pause
goto menu

:get_serial
cls
echo 正在获取设备序列号...
adb get-serialno
echo.
pause
goto menu

:device_status
cls
echo 正在查看设备状态...
echo.
echo 设备连接状态:
adb devices
echo.
echo 设备信息:
adb shell getprop ro.product.model
echo.
pause
goto menu

:start_app
cls
echo 启动应用
echo.
set /p package_name=请输入应用包名:
if "%package_name%"=="" goto start_app
set /p activity_name=请输入Activity名称 (可选):
if "%activity_name%"=="" (
    echo 正在启动应用...
    adb shell monkey -p "%package_name%" -c android.intent.category.LAUNCHER 1
) else (
    echo 正在启动应用...
    adb shell am start -n "%package_name%/%activity_name%"
)
echo.
pause
goto menu

:stop_app
cls
echo 强制停止应用
echo.
set /p package_name=请输入应用包名:
if "%package_name%"=="" goto stop_app
echo 正在强制停止应用...
adb shell am force-stop "%package_name%"
echo 应用已停止
echo.
pause
goto menu

:get_ip
cls
echo 正在获取设备IP地址...
echo.
echo 设备IP地址:
adb shell ip addr show wlan0 | findstr "inet "
echo.
echo 或者使用以下命令:
adb shell ifconfig wlan0
echo.
pause
goto menu

:wireless_connect
cls
echo 无线连接设备
echo.
echo 注意: 使用无线连接前，请确保:
echo 1. 设备已通过USB连接并启用了USB调试
echo 2. 设备和电脑在同一WiFi网络中
echo.
echo 请选择操作:
echo 1. 启用设备TCP模式(需要USB连接)
echo 2. 连接到设备
echo 0. 返回
echo.
set /p wireless_choice=请选择操作 (0-2):

if "%wireless_choice%"=="0" goto menu
if "%wireless_choice%"=="1" goto enable_tcp
if "%wireless_choice%"=="2" goto connect_wireless
goto wireless_connect

:enable_tcp
cls
echo 启用设备TCP模式
echo.
echo 请确保设备已通过USB连接...
echo.
set /p tcp_port=请输入TCP端口号 (默认: 5555):
if "%tcp_port%"=="" set tcp_port=5555
echo 正在启用TCP模式...
adb tcpip %tcp_port%
echo.
echo TCP模式已启用，端口: %tcp_port%
echo 现在可以拔掉USB线，使用选项2进行无线连接
echo.
pause
goto wireless_connect

:connect_wireless
cls
echo 连接无线设备
echo.
set /p device_ip=请输入设备IP地址:
if "%device_ip%"=="" goto connect_wireless
set /p device_port=请输入端口号 (默认: 5555):
if "%device_port%"=="" set device_port=5555
echo 正在连接到 %device_ip%:%device_port%...
adb connect %device_ip%:%device_port%
echo.
echo 连接状态:
adb devices
echo.
pause
goto wireless_connect

:disconnect_wireless
cls
echo 断开连接
echo.
echo 当前已连接设备:
adb devices
echo.
echo 请选择操作:
echo 1. 断开指定设备
echo 2. 断开所有设备
echo 0. 返回
echo.
set /p disconnect_choice=请选择 (0-2):

if "%disconnect_choice%"=="0" goto menu
if "%disconnect_choice%"=="1" goto disconnect_specific
if "%disconnect_choice%"=="2" goto disconnect_all
goto disconnect_wireless

:disconnect_specific
cls
echo 断开指定设备
echo.
set /p device_id=请输入要断开的设备IP地址或序列号:
if "%device_id%"=="" goto disconnect_specific
echo 正在断开 %device_id%...
adb disconnect %device_id%
echo.
echo 操作后连接状态:
adb devices

:scrcpy_menu
cls
echo 正在检查 Scrcpy 环境...
where scrcpy >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo 错误: 未在系统中找到 scrcpy 命令。
    echo 请确保 scrcpy 已安装并已添加到系统 PATH 环境变量中。
    echo.
    echo 你可以从这里下载: https://github.com/Genymobile/scrcpy/releases
    echo.
    pause
    goto menu
)

:scrcpy_submenu
cls
echo ========================================
echo            Scrcpy 高级投屏
echo ========================================
echo.
echo Scrcpy 环境正常。请选择操作:
echo.
echo 1.  启动默认镜像 (可控制)
echo 2.  启动只读模式 (仅显示，不可控)
echo 3.  录制屏幕 (保存到 scrcpy_record.mkv)
echo 4.  列出可用显示器
echo 5.  Low Quality (Fluent)
echo 6.  指定显示器
echo 0.  返回
echo.
echo ========================================
echo.
set /p scrcpy_choice=请输入选项 (0-6):

if "%scrcpy_choice%"=="0" goto menu
if "%scrcpy_choice%"=="1" goto scrcpy_default
if "%scrcpy_choice%"=="2" goto scrcpy_no_control
if "%scrcpy_choice%"=="3" goto scrcpy_record
if "%scrcpy_choice%"=="4" goto scrcpy_list_displays
if "%scrcpy_choice%"=="5" goto scrcpy_low_quality
if "%scrcpy_choice%"=="6" goto scrcpy_select_display
goto scrcpy_submenu

:scrcpy_default
cls
echo 正在启动 Scrcpy 默认模式...
start "" scrcpy
goto scrcpy_submenu

:scrcpy_no_control
cls
echo 正在启动 Scrcpy 只读模式...
start "" scrcpy --no-control
goto scrcpy_submenu

:scrcpy_record
cls
echo 正在启动 Scrcpy 录屏模式...
echo 视频将保存为 scrcpy_record.mkv，保存在当前目录下。
echo.
echo 请注意: 录屏期间 scrcpy 窗口可能不会显示。
echo 关闭这个窗口来停止录制.
echo.
scrcpy --record=scrcpy_record.mkv
echo.
echo 录制已停止。
pause
goto scrcpy_submenu

:scrcpy_list_displays
cls
echo 正在列出可用显示器...
echo.
scrcpy --list-displays
echo.
pause
goto scrcpy_submenu

:scrcpy_low_quality
cls
echo Starting Scrcpy (Low Quality)...
start "" scrcpy --video-bit-rate=2M --max-size=800

:scrcpy_select_display
cls
echo 正在列出可用显示器...
echo.
scrcpy --list-displays
echo.
echo ========================================
echo.
set /p display_id=请输入要镜像的显示器ID (直接按回车返回主菜单):
if not defined display_id goto menu

echo.
set /p choice_crop=请选择裁剪模式 (1=自动平分, 2=手动输入, 0=否):

if "%choice_crop%"=="1" goto scrcpy_auto_crop
if "%choice_crop%"=="2" goto scrcpy_manual_crop

call :launch_scrcpy %display_id%
goto scrcpy_submenu

:scrcpy_auto_crop
echo.
echo 正在自动获取显示器 %display_id% 的分辨率...

set "full_width="
set "full_height="

for /f "tokens=2,3 delims=()x" %%a in ('scrcpy --list-displays 2^>^&1 ^| findstr /C:"--display-id=%display_id%"') do (
    set "full_width=%%a"
    set "full_height=%%b"
)

if not defined full_width (
    echo.
    echo 错误: 无法自动获取分辨率。
    echo 请尝试手动输入裁剪参数。
    echo.
    pause
    goto scrcpy_submenu
)

echo 成功获取分辨率: %full_width%x%full_height%

set /a new_width=%full_width% / 2
set "auto_crop_params=--crop=%new_width%:%full_height%:0:0"
echo 正在启动 Scrcpy, 自动裁剪为: %new_width%:%full_height%:0:0
call :launch_scrcpy %display_id% "%auto_crop_params%"
goto scrcpy_submenu

:scrcpy_manual_crop
echo.
echo 请输入完整裁剪参数 (格式: 宽度:高度:X:Y, 例如 1920:1080:0:0)
set /p crop_params=裁剪参数:
if not defined crop_params goto scrcpy_no_crop

set "manual_crop_params=--crop=%crop_params%"
echo 正在启动 Scrcpy, 应用手动裁剪...
call :launch_scrcpy %display_id% "%manual_crop_params%"
goto scrcpy_submenu

:scrcpy_no_crop
echo 输入无效, 将不进行裁剪...
call :launch_scrcpy %display_id%
goto scrcpy_submenu

:launch_scrcpy
echo.
echo --- Launching Scrcpy ---
echo Command: scrcpy --display-id=%1 %~2
echo The script will continue after you close the scrcpy window.
echo.
scrcpy --display-id=%1 %~2
goto :eof


echo.
pause
goto menu

:disconnect_all
cls
echo 正在断开所有设备...
adb disconnect
echo.
echo 操作后连接状态:
adb devices
echo.
pause
goto menu

:exit
cls
echo 感谢使用ADB工具！
echo.
pause
exit