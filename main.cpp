#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>
#include <QQmlContext>
#include "../QModules/src/imagepicker/imagepicker.h"

int main(int argc, char *argv[])
{
    QApplication::setApplicationName("App");
    QApplication::setOrganizationName("com.twodevs");
    QApplication::setOrganizationName("2Devs");
    QApplication::setApplicationVersion("1.0");
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);

    QApplication app(argc, argv);

    qmlRegisterType<ImagePicker>("Qmodules.ImagePicker", 1, 0, "ImagePicker");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QIcon::setThemeSearchPaths({":/"});
    QIcon::setThemeName("material-round");
    QQuickStyle::setStyle(":/UiKit");
    QQuickStyle::setFallbackStyle("Default");
    engine.addImportPath(":/");

    engine.load(url);

    return app.exec();
}
