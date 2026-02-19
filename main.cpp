#include <gst/gst.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngineExtensionPlugin>
#include <QQuickWindow>

#include "WebRTSP/Qt/QML/QmlLibGst.h"


Q_IMPORT_QML_PLUGIN(org_webrtsp_clientPlugin)

int main(int argc, char *argv[])
{
    QmlLibGst libGst;

    QGuiApplication app(argc, argv);

    // trick to load plugin and register required QML elements
    if(GstPlugin* plugin = gst_plugin_load_by_name("qml6")) {
        gst_object_unref(plugin);
    } else {
        qCritical() << "Something went wrong with Qt6 Qml GStreamer plugin load";
        return -1;
    }

    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
    Qt::QueuedConnection);
    engine.loadFromModule("QMLDemo", "Main");

    return app.exec();
}
