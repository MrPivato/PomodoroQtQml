#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "countdowntimer.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QCoreApplication::setOrganizationName("PivatoSoft");
    QCoreApplication::setOrganizationDomain("https://mrpivato.neocities.org/");
    QCoreApplication::setApplicationName("Pomodoro Timer");

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/Resources/app_icon.png"));

    CountDownTimer countDownTimer;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("TimerClass", &countDownTimer);

    QQuickStyle::setStyle("Imagine");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
