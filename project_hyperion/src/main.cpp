#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setApplicationName("Project Hyperion");
    QApplication::setOrganizationName("Hyperion Labs");

    MainWindow window;
    window.resize(1280, 720);
    window.show();

    return app.exec();
}
