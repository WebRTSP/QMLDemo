## Build on Ubuntu 25.10 for Android with Qt 6.10.2

### Build patched GStreamer 1.28 (with fixed Qt 6 support)
1. run `sudo apt install build-essential git cmake openjdk-17-jdk python3.13-venv`
2. install Qt 6.10.2 for Android with `Qt Online Installer` to `$HOME/Qt`  
	_Note: Ensure `Qt Shader Tools` is selected under the `Additional Libraries` section_
3. open QtCreator and configure build environment for Android (Edit > Preferences... > SDKs > Android)
4. run `git clone https://github.com/RSATom/cerbero.git && cd cerbero && git checkout 1.28_android`
5. run `export QMAKE6_android_arm64=~/Qt/6.10.2/android_arm64_v8a/bin/qmake && export QMAKE6_android_x86_64=~/Qt/6.10.2/android_x86_64/bin/qmake`
6. run `./cerbero-uninstalled -c config/cross-android-universal.cbc bootstrap`
7. run`./cerbero-uninstalled -c patched_gstreamer.cbc -c config/cross-android-universal.cbc -v qt6 package gstreamer-1.0`
8. extract `gstreamer-1.0-android-universal-1.28.0.1.tar.xz` to `$HOME`

### Build QMLDemo
1. add environment variable `GSTREAMER_ANDROID_ROOT=~/gstreamer-1.0-android-universal-1.28.0.1` (for example in Edit > Preferences... > Environment > System -> Environment)
2. run `git clone https://github.com/WebRTSP/QMLDemo.git --recursive`
3. open `CMakeLists.txt` from project root in Qt Creator
4. select `Qt 6.10.2 for Android arm64-v8a` and/or `Qt 6.10.2 for Android x86_64` as build kit
5. build application and run
