#include "logic/meditationcontroller.h"
#include "logic/timer.h"
#include "model/meditationmodel.h"
//#include <QAndroidJniObject>
#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl) QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    //    QAndroidJniObject::getStaticField<int>("android.content.pm.ActivityInfo",
    //                                           "SCREEN_ORIENTATION_LANDSCAPE");
    // Create objects
    auto timer = med::Timer();
    auto meditation_model = MeditationModel();
    auto meditation_controller = med::MeditationController(timer, meditation_model, &app);

    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/qml/Constants.qml")), "MeditationApp", 1, 0,
                             "Constants");

    qmlRegisterUncreatableType<MeditationModel>("MeditationApp", 1, 0, "MeditationState",
                                                "Not creatable as it is an enum type");

    qRegisterMetaType<MeditationModel::MeditationState>("MeditationState");

    engine.rootContext()->setContextProperty("meditationModel", &meditation_model);

    engine.load(url);
    return app.exec();
}
