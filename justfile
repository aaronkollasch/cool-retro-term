set export

PATH := "/opt/homebrew/opt/qt@5/bin:/usr/local/bin:/usr/bin:/bin"
LDFLAGS := "-L/opt/homebrew/opt/qt@5/lib"
LFLAGS := "-L/opt/homebrew/opt/qt@5/lib"
CFLAGS := "-I/opt/homebrew/opt/qt@5/include"
CPPFLAGS := "-I/opt/homebrew/opt/qt@5/include"
CXXFLAGS := "-I/opt/homebrew/opt/qt@5/include"
INCPATH := "-I/opt/homebrew/opt/qt@5/include"
PKG_CONFIG_PATH := "/opt/homebrew/opt/qt@5/lib/pkgconfig"
#QTDIR := "/opt/homebrew/opt/qt@5"
#QT_SELECT := "qt5"

build:
    # https://github.com/Swordfish90/cool-retro-term/wiki/Build-Instructions-(macOS)
    # https://github.com/Swordfish90/cool-retro-term/issues/761
    qmake --version
    qmake -config release
    rm -f cool-retro-term.app/Contents/Info.plist
    make -j8
    mkdir -p cool-retro-term.app/Contents/PlugIns
    cp -r qmltermwidget/QMLTermWidget cool-retro-term.app/Contents/PlugIns

    # https://juju.one/change-mac-gui-app-environment-variable/
    /usr/libexec/PlistBuddy -c "Add :LSEnvironment:LANG string" cool-retro-term.app/Contents/Info.plist
    /usr/libexec/PlistBuddy -c "Set :LSEnvironment:LANG en_US.UTF-8" cool-retro-term.app/Contents/Info.plist

clean:
    make clean

run:
    /opt/homebrew/bin/just build
    # run the binary directly
    env -i PATH=$PATH HOME=$HOME LANG=en_US.UTF-8 ./cool-retro-term.app/Contents/MacOS/cool-retro-term
    # or, open the .app
    # # reload Info.plist
    # /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -v -f cool-retro-term.app
    # env -i PATH=$PATH HOME=$HOME LANG=en_US.UTF-8 open ./cool-retro-term.app

run-terminal:
    zsh
