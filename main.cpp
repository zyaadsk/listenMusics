#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "kugou.h"
#include "mainwindow.h"

int main(int argc, char *argv[]) {
  QApplication a(argc, argv);
  // template <typename T> int qmlRegisterType(const char *uri, int
  // versionMajor, int versionMinor, const char *qmlName)
  //这个模板函数在QML系统中用名称qmlName注册c++类型，在从uri导入的库中使用由versionMajor和versionMinor组成的版本号。返回QML类型id。
  qmlRegisterType<KuGou, 1>("KuGou", 1, 0, "KuGou");
  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/qml/MainWindow.qml"));
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &a,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);
  return a.exec();
}
