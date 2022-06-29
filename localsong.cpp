#include "localsong.h"

#include <fstream>
#include <iostream>
#include <id3/tag.h>
#include <QVariant>
#include <taglib/id3v1tag.h>
#include <taglib/id3v2tag.h>
#include <taglib/tag.h>
#include <taglib/wavfile.h>
#include <taglib/mpegfile.h>
#include <taglib/flacfile.h>
#include <taglib/vorbisfile.h>
#include <taglib/xiphcomment.h>
#include <taglib/attachedpictureframe.h>

#include <QDebug>

LocalSong::LocalSong(QObject *parent)
    : QObject{parent}
{

}

void LocalSong::songInfo(QString url)
{
    m_Tags.clear();
    qDebug()<< "url:" << url;

    QString locaUrl = url.remove(url.left(7));
    QByteArray ba=locaUrl.toUtf8();
    const char *ch=ba.data();

    qDebug() << "ch"<<ch;

    TagLib::MPEG::File *localFile = new TagLib::MPEG::File(ch);

    if(localFile->isOpen()){
        m_Tags["歌名"] = localFile->tag()->title().toCString();
        m_Tags["艺术家"] = localFile->tag()->artist().toCString();

        qDebug() << localFile->tag()->title().toCString() <<" " << localFile->tag()->artist().toCString();

    }

    TagLib::ID3v2::Tag *id3v2tag = localFile->ID3v2Tag();
    if(id3v2tag){
        TagLib::ID3v2::FrameList frameList = localFile->ID3v2Tag()->frameListMap()["APIC"];
        if(!frameList.isEmpty()){
            TagLib::ID3v2::AttachedPictureFrame *picFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *> (frameList.front());
            char *jpgFileName = "/tmp/cover.jpg";
            FILE *fd = fopen(jpgFileName,"wb");
            if(fd != NULL){
                fwrite(picFrame->picture().data(),picFrame->size(),1,fd);
                fclose(fd);
            }
//                std::cout <<" The album picture has been written to cover.jpg";
                qDebug() << " The album picture has been written to cover.jpg";
        }

    }
}

const QVariantMap &LocalSong::Tags() const
{
    return m_Tags;
}

void LocalSong::setTags(const QVariantMap &newTags)
{
    if (m_Tags == newTags)
        return;
    m_Tags = newTags;
    emit TagsChanged();
}
