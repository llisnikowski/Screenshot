#include "screenshot.h"

Screenshot::Screenshot(QObject *parent) : QObject(parent)
{
    copyImage = false;
    saveImageOpt = false;
    hideThisWindow = true;

    clipboard = QGuiApplication::clipboard();

    currentScreen = QGuiApplication::primaryScreen();
    screensList = QGuiApplication::screens();
    countGeometryScreens();
    ssArea.setRect(100,100,1000,500);

    shootScreen();


}



void Screenshot::newScreenshot(){

    shootScreen();
    /*
    if(hideThisWindow)
        QTimer::singleShot(200,this, &Screenshot::shootScreen);
    else
        shootScreen();*/
}

void Screenshot::shootScreen(){
    pixmap = currentScreen->grabWindow(0,ssArea.x(),ssArea.y(),ssArea.width(),ssArea.height());

    if(copyImage)   clipboard->setImage(pixmap.toImage());

    emit ssImageChanged();

    if(saveImageOpt && !pathText.isEmpty() && !imageNameText.isEmpty()){
        QString a = findNameImage();
        pixmap.save(pathText +"/"+ a +".png");
    }
}

void Screenshot::copyImageToClipboard(){
    clipboard->setImage(pixmap.toImage());
}

QString Screenshot::findNameImage(){
    if(imageNameText.indexOf('@') == -1)
        return imageNameText;
    //qDebug()<<"Files: ";

    QDir directory(pathText);
    QStringList images = directory.entryList(QStringList() << "*.PNG" ,QDir::Files);
    //QDir::setSearchPaths("icons",QStringList(pathText));
    //QList<QString> fileInPath = QDir::searchPaths("icons");



    for(int i=0;i<1000;i++){
        bool foundSameName = false;
        QString newName = imageNameText;
        newName = newName.replace("@",QString::number(i));
        for(int i=0;i<images.length();i++){
            if(images.at(i) == newName+".png" || images.at(i) == newName+".PNG"){
                foundSameName=true;
                break;
            }
        }
        if(foundSameName) continue;
        return newName;
    }
    //qDebug()<<"n:"+ imageNameText;
    return imageNameText;
}


QString Screenshot::imageToUrl(QImage img){
    QByteArray bArray;
    QBuffer buffer(&bArray);
    buffer.open(QIODevice::WriteOnly);
    img.save(&buffer, "JPEG");

    QString imageS("data:image/jpg;base64,");
    imageS.append(QString::fromLatin1(bArray.toBase64().data()));
    return imageS;
}

void Screenshot::countGeometryScreens(){
    screensList = QGuiApplication::screens();
    geometryScreens.setRect(0,0,0,0);

    for(int i=0;i<screensList.count();i++){
        geometryScreens = geometryScreens.united(screensList.at(i)->geometry());
    }
    emit geometryScreensChanged();
}


//-----| Slots |-----

//Get/Set bool copyImage
bool Screenshot::getCopyImage(){ return copyImage;}
void Screenshot::setCopyImage(bool _copyImage){copyImage=_copyImage;}

//Get/Set saveImageOpt
bool Screenshot::getSaveImageOpt(){return saveImageOpt;}
void Screenshot::setSaveImageOpt(bool _saveOption){saveImageOpt=_saveOption;}

//Get/Set hideThisWindow
bool Screenshot::getHideThisWindow(){return hideThisWindow;}
void Screenshot::setHideThisWindow(bool hideWindow){hideThisWindow=hideWindow;}

//Get QPixmap pixmap;
QString Screenshot::getSsImage(){return imageToUrl(pixmap.toImage());}

//Get QRect geometryScreens;
QRect Screenshot::getGeometryScreens(){return geometryScreens;}

//Get/Set QRect ssArea
QRect Screenshot::getSsArea(){return ssArea;}
void Screenshot::setSsArea(QRect _ssArea){ ssArea=_ssArea;}

//Get/Set Path
QString Screenshot::getPathText(){return pathText;}
void Screenshot::setPathText(QString path){pathText=path;}

//Get/Set Name
QString Screenshot::getImageNameText(){return imageNameText;}
void Screenshot::setImageNameText(QString name){imageNameText=name;}












