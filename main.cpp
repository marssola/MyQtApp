#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Who am I");
    QGuiApplication::setOrganizationName("com.marssola");
    QGuiApplication::setOrganizationName("Marssola");
    QGuiApplication::setApplicationVersion("1.0");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QIcon::setThemeSearchPaths({ ":/" });
    QIcon::setThemeName("material-round");
    QQuickStyle::setStyle(":/UiKit");
    QQuickStyle::setFallbackStyle("Default");
    engine.addImportPath(":/");

    engine.load(url);

    return app.exec();
}
