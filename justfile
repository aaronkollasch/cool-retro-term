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
    make -j8
    mkdir -p cool-retro-term.app/Contents/PlugIns
    cp -r qmltermwidget/QMLTermWidget cool-retro-term.app/Contents/PlugIns

clean:
    make clean

run:
    /opt/homebrew/bin/just build
    ./cool-retro-term.app/Contents/MacOS/cool-retro-term

run-terminal:
    zsh
