## Build on Windows 11 with Qt 6.10.2

### Build patched GStreamer 1.28 with fixed Qt 6 plugin
1. install `MSVC 2022 64-bit` Qt variant with `Qt Online Installer` to `C:\Qt`  
    _Note: Ensure `Qt Shader Tools` is selected under the `Additional Libraries` section_
2. open `Windows PowerShell` (with right mouse button click on Window Start menu button -> `Terminal`) and run following:
```
cd ~
git clone https://github.com/RSATom/cerbero.git
cd cerbero
git checkout 1.28_patched
```
3. set `QMAKE6=C:\Qt\6.10.2\msvc2022_64\bin\qmake.exe` environment variable
4. open `Windows PowerShell` with administrator permissions (with right mouse button click on Window Start menu button -> `Terminal (Admin)`) and run following:
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
cd ~\cerbero
.\tools\bootstrap-windows.ps1 -VSVersion '2022'
```
5. back to `Windows PowerShell` and run following:
```
cd ~\cerbero
.\cerbero-uninstalled bootstrap
.\cerbero-uninstalled -c .\patched_gstreamer.cbc -v qt6 package gstreamer-1.0
start gstreamer-1.0-msvc-x86_64-1.28.1.1.exe
```

### Build QMLDemo
1. run `git clone https://github.com/WebRTSP/QMLDemo.git --recursive`
2. open `CMakeLists.txt` from project root in Qt Creator
3. select `Desktop Qt 6.10.2 MSVC2022 64bit` as build kit and `Release` or `Release with Debug information` build configuration
4. build application and run

## Build on Ubuntu 25.10
1. install dependancies:
```
sudo apt install build-essential git cmake pkgconf \
    libspdlog-dev libspdlog-dev libgio-2.0-dev \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev \
    qt6-declarative-dev qt6-websockets-dev gstreamer1.0-qt6 \
    libnice-dev \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-nice gstreamer1.0-libav \
    qtcreator qt6-base-dev
```
2. `git clone https://github.com/WebRTSP/QMLDemo.git --recursive`
3. open `CMakeLists.txt` from project root in Qt Creator
4. select `Desktop` as build kit
5. build application and run

## Build on Ubuntu 25.10 for Android with Qt 6.10.2

### Build patched GStreamer 1.28 with fixed Qt 6 support
1. run `sudo apt install build-essential git git-lfs cmake openjdk-17-jdk python3.13-venv`
2. install Qt 6.10.2 for Android with `Qt Online Installer` to `$HOME/Qt`  
    _Note: Ensure `Qt Shader Tools` is selected under the `Additional Libraries` section_
3. open QtCreator and configure build environment for Android (Edit > Preferences... > SDKs > Android)
4. run `git clone https://github.com/RSATom/cerbero.git && cd cerbero && git checkout 1.28_patched`
5. run `export QT6_PREFIX=~/Qt/6.10.2`
6. run `./cerbero-uninstalled -c config/cross-android-universal.cbc bootstrap`
7. run`./cerbero-uninstalled -c patched_gstreamer.cbc -c config/cross-android-universal.cbc -v qt6 package gstreamer-1.0`
8. extract `gstreamer-1.0-android-universal-1.28.1.1.tar.xz` to `$HOME`

### Build QMLDemo
1. add environment variable `GSTREAMER_ANDROID_ROOT=~/gstreamer-1.0-android-universal-1.28.1.1` (for example in Edit > Preferences... > Environment > System -> Environment)
2. run `git clone https://github.com/WebRTSP/QMLDemo.git --recursive`
3. open `CMakeLists.txt` from project root in Qt Creator
4. select `Qt 6.10.2 for Android arm64-v8a` and/or `Qt 6.10.2 for Android x86_64` as build kit
5. build application and run
