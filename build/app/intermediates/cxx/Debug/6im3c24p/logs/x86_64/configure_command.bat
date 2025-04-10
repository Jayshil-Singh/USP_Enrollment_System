@echo off
"C:\\Users\\ryanr\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\Flutter SDK\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=23" ^
  "-DANDROID_PLATFORM=android-23" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=C:\\Users\\ryanr\\AppData\\Local\\Android\\sdk\\ndk\\28.0.13004108" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\ryanr\\AppData\\Local\\Android\\sdk\\ndk\\28.0.13004108" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\ryanr\\AppData\\Local\\Android\\sdk\\ndk\\28.0.13004108\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\ryanr\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\Users\\ryanr\\OneDrive\\Desktop\\cs415_project\\build\\app\\intermediates\\cxx\\Debug\\6im3c24p\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\Users\\ryanr\\OneDrive\\Desktop\\cs415_project\\build\\app\\intermediates\\cxx\\Debug\\6im3c24p\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\Users\\ryanr\\OneDrive\\Desktop\\cs415_project\\android\\app\\.cxx\\Debug\\6im3c24p\\x86_64" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
