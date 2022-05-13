#ifndef SCREENSHOT_H
#define SCREENSHOT_H

#include <QObject>

#include <QDebug>
#include <QPixmap>
#include <QScreen>
#include <QGuiApplication>
#include <QBuffer>
#include <QList>
#include <QClipboard>
#include <QWindow>
#include <QTimer>
#include <QDir>

#include <QtGui>


class Screenshot : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(bool copyImageOpt READ getCopyImage WRITE setCopyImage NOTIFY copyImageChanged)
    Q_PROPERTY(bool saveImageOpt READ getSaveImageOpt WRITE setSaveImageOpt NOTIFY saveImageOptChange)
    Q_PROPERTY(bool hideThisWindow READ getHideThisWindow WRITE setHideThisWindow NOTIFY hideThisWindowChange)
    Q_PROPERTY(QString ssImage READ getSsImage NOTIFY ssImageChanged)
    Q_PROPERTY(QRect geometryScreens READ getGeometryScreens NOTIFY geometryScreensChanged)
    Q_PROPERTY(QRect ssArea READ getSsArea WRITE setSsArea NOTIFY ssAreaChanged)
    Q_PROPERTY(QString pathText READ getPathText WRITE setPathText NOTIFY pathTextChanged)
    Q_PROPERTY(QString imageNameText READ getImageNameText WRITE setImageNameText NOTIFY imageNameTextChanged)

public:
    explicit Screenshot(QObject *parent = nullptr);

public slots:
//Buttons
    void newScreenshot();
    void copyImageToClipboard();


//Q_PROPERTY
    bool getCopyImage();
    void setCopyImage(bool _copyImage);

    bool getSaveImageOpt();
    void setSaveImageOpt(bool _saveOption);

    bool getHideThisWindow();
    void setHideThisWindow(bool hideWindow);

    QString getSsImage();

    QRect getGeometryScreens();

    QRect getSsArea();
    void setSsArea(QRect _ssArea);

    QString getPathText();
    void setPathText(QString path);

    QString getImageNameText();
    void setImageNameText(QString name);

private:
    QString imageToUrl(QImage);
    void countGeometryScreens();
    void shootScreen();
    QString findNameImage();

signals:
    void copyImageChanged();
    void ssImageChanged();
    void hideThisWindowChange();
    void geometryScreensChanged();
    void ssAreaChanged();
    void saveImageOptChange();
    void pathTextChanged();
    void imageNameTextChanged();

private:

    QPixmap pixmap;
    QClipboard *clipboard;

    QScreen *currentScreen;
    QList<QScreen *> screensList;
    QRect geometryScreens;
    QRect ssArea;

    bool copyImage;
    bool saveImageOpt;
    bool hideThisWindow;

    QString pathText;
    QString imageNameText;

};

#endif // SCREENSHOT_H
