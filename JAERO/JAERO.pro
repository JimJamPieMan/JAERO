#-------------------------------------------------
#
# Project created by QtCreator 2015-08-01T20:41:23
# Jonti Olds
#
#-------------------------------------------------

#the three tricky things will be libvorbis,libogg, and libcorrect
#the settings I have here are for my setup but other most likely will install the libraries
#so you will need to point everything to the right place.
#if you are having trubbles focus on things like "LIBS += -L$$OGG_PATH/src/.libs"
#remember to compile libvorbis,libogg, and libcorrect before compiling this

QT       += multimedia core network gui svg sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets  printsupport

TARGET = JAERO
TEMPLATE = app

INSTALL_PATH = /opt/jaero

QMAKE_CXXFLAGS += -std=c++11

#for audio compressor
#compiling libogg "./configure" "make" works. for comping libvorbis without installing in usual place libogg was "./configure --with-ogg-libraries=/e/git/JAERO/libogg-1.3.3/src/.libs  --with-ogg-includes=/e/git/JAERO/libogg-1.3.3/include" then "make"
VORBIS_PATH = $$PWD/../libvorbis-1.3.6
OGG_PATH = $$PWD/../libogg-1.3.3

# I've moved libacars source to outside JAERO repo so I can
# clone libacars and update easier. Really this should be
# done for the other libs here rather than including them
# in the JAERO repo. The downside is more repos have to be
# downloaded.
LIBACARS_PATH =$$PWD/../../libacars

INCLUDEPATH += $$VORBIS_PATH/include
DEPENDPATH += $$VORBIS_PATH/include
VPATH += $$VORBIS_PATH/include

INCLUDEPATH += $$OGG_PATH/include
DEPENDPATH += $$OGG_PATH/include
VPATH += $$OGG_PATH/include

INCLUDEPATH += $$LIBACARS_PATH/src

#message("QT_ARCH is \"$$QT_ARCH\"");
contains(QT_ARCH, i386) {
    #message("32-bit")
    DEFINES += kiss_fft_scalar=float
} else {
    #message("64-bit")
    DEFINES += kiss_fft_scalar=double
}

DEFINES += _USE_MATH_DEFINES

SOURCES += main.cpp\
        mainwindow.cpp \
    coarsefreqestimate.cpp \
    DSP.cpp \
    mskdemodulator.cpp \
    ../qcustomplot/qcustomplot.cpp \
    audiomskdemodulator.cpp \
    gui_classes/console.cpp \
    gui_classes/qscatterplot.cpp \
    gui_classes/qspectrumdisplay.cpp \
    gui_classes/qled.cpp \
    ../kiss_fft130/kiss_fft.c \
    fftwrapper.cpp \
    fftrwrapper.cpp \
    ../kiss_fft130/kiss_fftr.c \
    gui_classes/textinputwidget.cpp \
    gui_classes/settingsdialog.cpp \
    aerol.cpp \
    gui_classes/planelog.cpp \
    downloadmanager.cpp \
    databasetext.cpp \
    oqpskdemodulator.cpp \
    audiooqpskdemodulator.cpp \
    ../kiss_fft130/kiss_fastfir.c \
    burstoqpskdemodulator.cpp \
    audioburstoqpskdemodulator.cpp \
    arincparse.cpp \
    tcpserver.cpp \
    sbs1.cpp \
    tcpclient.cpp \
    burstmskdemodulator.cpp \
    audioburstmskdemodulator.cpp \
    jconvolutionalcodec.cpp \
    audiooutdevice.cpp \
    compressedaudiodiskwriter.cpp


HEADERS  += mainwindow.h \
    coarsefreqestimate.h \
    DSP.h \
    mskdemodulator.h \
    ../qcustomplot/qcustomplot.h \
    audiomskdemodulator.h \
    gui_classes/console.h \
    gui_classes/qscatterplot.h \
    gui_classes/qspectrumdisplay.h \
    gui_classes/qled.h \
    ../kiss_fft130/_kiss_fft_guts.h \
    ../kiss_fft130/kiss_fft.h \
    fftwrapper.h \
    fftrwrapper.h \
    ../kiss_fft130/kiss_fftr.h \
    gui_classes/textinputwidget.h \
    gui_classes/settingsdialog.h \
    aerol.h \
    gui_classes/planelog.h \
    downloadmanager.h \
    databasetext.h \
    oqpskdemodulator.h \
    audiooqpskdemodulator.h \
    ../kiss_fft130/kiss_fastfir.h \
    burstoqpskdemodulator.h \
    audioburstoqpskdemodulator.h \
    arincparse.h \
    tcpserver.h \
    sbs1.h \
    tcpclient.h \
    burstmskdemodulator.h \
    audioburstmskdemodulator.h \
    jconvolutionalcodec.h \
    audiooutdevice.h \
    compressedaudiodiskwriter.h


FORMS    += mainwindow.ui \
    gui_classes/settingsdialog.ui \
    gui_classes/planelog.ui

RESOURCES += \
    jaero.qrc

DISTFILES += \
    LICENSE \
    ../kiss_fft130/TIPS \
    ../kiss_fft130/CHANGELOG \
    ../kiss_fft130/COPYING \
    ../kiss_fft130/README \
    ../qcustomplot/changelog.txt \
    ../qcustomplot/GPL.txt \
    ../README.md \
    ../images/screenshot-win-main.png \
    ../images/screenshot-win-planelog.png \
    ../libvorbis-1.3.6/CHANGES \
    ../libvorbis-1.3.6/AUTHORS \
    ../libvorbis-1.3.6/COPYING \
    ../libogg-1.3.3/CHANGES \
    ../libogg-1.3.3/AUTHORS

win32 {
RC_FILE = jaero.rc

}

win32 {
#on windows the libcorrect dlls are here
INCLUDEPATH +=../libcorrect/include
contains(QT_ARCH, i386) {
    #message("32-bit")
    LIBS += -L$$PWD/../libcorrect/bin/32
} else {
    #message("64-bit")
    LIBS += -L$$PWD/../libcorrect/bin/64
}
}
LIBS += -lcorrect

# remove possible other optimization flags
#QMAKE_CXXFLAGS_RELEASE -= -O
QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CXXFLAGS_RELEASE += -O3

# add the desired -O3 if not present
#QMAKE_CXXFLAGS_RELEASE *= -O3

#for audio compressor
#for static building order seems to matter
#LIBS += -L$$VORBIS_PATH/lib/.libs -lvorbis -lvorbisenc
#LIBS += -L$$OGG_PATH/src/.libs -logg
# if you have installed the libs ie. "make install" then this will do instead
LIBS += -lvorbis -lvorbisenc -logg

# libacars support
LIBS += -L$$LIBACARS_PATH/build/src/libacars

#this used to be needed in the old versions of qt/mingw on windows but now you dont need it.
#win32 {
#contains(QT_ARCH, i386) {
#    #message("32-bit")
#    LIBS += -L$$LIBACARS_PATH/bin/32
#} else {
#    #message("64-bit")
#    LIBS += -L$$LIBACARS_PATH/bin/64
#}
#}

#in windows use the dynamic lib rather than the static one even when stattically compiling
win32 {
LIBS += -lacars.dll
} else {
LIBS += -lacars
}

#this can have issues in qtcreator
#define where we store everything so when using the command line we don't make the main directory messy.
#CONFIG(debug, debug|release) {
#    DESTDIR = $$PWD/debug
#    OBJECTS_DIR = $$PWD/tmp/debug/stuff
#    MOC_DIR = $$PWD/tmp/debug/stuff
#    UI_DIR = $$PWD/tmp/debug/stuff
#    RCC_DIR = $$PWD/tmp/debug/stuff
#} else {
#    DESTDIR = $$PWD/release
#    OBJECTS_DIR = $$PWD/tmp/release/stuff
#    MOC_DIR = $$PWD/tmp/release/stuff
#    UI_DIR = $$PWD/tmp/release/stuff
#    RCC_DIR = $$PWD/tmp/release/stuff
#}

#desktop
desktop.path = /usr/share/applications
desktop.files += JAERO.desktop
INSTALLS += desktop

#icon
icon.path = $$INSTALL_PATH
icon.files += jaero.ico
INSTALLS += icon

#install sounds
soundsDataFiles.path = $$INSTALL_PATH/sounds/
soundsDataFiles.files = sounds/*.*
INSTALLS += soundsDataFiles

#install library
target.path=$$INSTALL_PATH
INSTALLS += target

# disable stupid deprecated-copy warnings
# cluttering up issues
QMAKE_CXXFLAGS += '-Wno-deprecated-copy'

#QMAKE_CXXFLAGS += '-Werror=format-security'
