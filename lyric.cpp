/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

#include "lyric.h"

#include <QRegularExpression>
#include <QRegularExpressionMatch>
#include <QTextStream>
#include <QFile>

#include <QDebug>

Lyric::Lyric(QObject *parent)
    : QObject{parent}
{

}


const QVector<QString> &Lyric::onelineLyric() const
{
    return m_onelineLyric;
}

void Lyric::setOnelineLyric(const QVector<QString> &newOnelineLyric)
{
    if (m_onelineLyric == newOnelineLyric)
        return;
    m_onelineLyric = newOnelineLyric;
    emit onelineLyricChanged();
}

const QVector<int> &Lyric::time() const
{
    return m_time;
}

void Lyric::setTime(const QVector<int> &newTime)
{
    if (m_time == newTime)
        return;
    m_time = newTime;
    emit timeChanged();
}

//解析线上歌词
void Lyric::divideLyrics()
{
    QVector <QString>().swap(m_onelineLyric);   //清楚m_onelineLyric中的歌词数据
    QVector <int>().swap(m_time);   //清楚m_time中的数据


    getLyric();

    QRegularExpression rex("\\[(id)?(hash)?(sign)?(qq)?(total)?"
                           "(ar)?(ti)?(al)?(by)?(offset)?(\\d+)?:(\\d+)?(\\.\\d+)?(\\S+)?\\]");
    QRegularExpressionMatch Match;

    //将歌词按行分解为歌词列表
    QStringList lines = m_lyric.split("\r\n");
//    qDebug() << lines;

    foreach(QString oneline,lines){

        Match = rex.match(oneline);

        QString currentLyric;
        int time;

        currentLyric = QString(oneline).right(QString(oneline).length()-Match.capturedLength());    //获取每一句歌词
//        qDebug() << currentLyric;
        if(currentLyric!=""&&currentLyric!="]"){
            m_onelineLyric.push_back(currentLyric);

            time = Match.captured(11).toInt()*60000 + Match.captured(12).toInt()*1000+Match.captured(14).toInt();   //获取每一句歌词的时间

            m_time.push_back(time);
        }

    }
}

//解析本地歌词
void Lyric::divideLocalLyric()
{
    QVector <QString>().swap(m_onelineLyric);   //清楚m_onelineLyric中的歌词数据
    QVector <int>().swap(m_time);   //清楚m_time中的数据

//    qDebug() << m_localFileUrl;

    QString lrcFileUrl = m_localFileUrl.remove(m_localFileUrl.right(3)).remove(m_localFileUrl.left(7))+"lrc";

//    qDebug() << lrcFileUrl;

    //打开歌词文件
    QFile lyricFile(lrcFileUrl);
    if(!lyricFile.open(QIODevice::ReadOnly | QIODevice::Text)){
        m_onelineLyric.push_back("暂无歌词");
        return;
    }

    QTextStream fileIn(&lyricFile);
    m_lyric = fileIn.readAll();

    lyricFile.close();



    //将歌词按行分解为歌词列表
    QStringList lines = m_lyric.split("\n");

    QRegularExpression rex("\\[(id)?(hash)?(sign)?(qq)?(total)?"
                           "(ar)?(ti)?(al)?(by)?(offset)?(\\d+)?:(\\d+)?(\\.\\d+)?(\\S+)?\\]");
    QRegularExpressionMatch Match;

    foreach(QString oneline,lines){
        qDebug() << oneline;

        Match = rex.match(oneline);

        QString currentLyric;
        int time;

        currentLyric = QString(oneline).right(QString(oneline).length()-Match.capturedLength());    //获取每一句歌词
        if(currentLyric!=""&&currentLyric!="]"){
            m_onelineLyric.push_back(currentLyric);
            qDebug() << currentLyric;

            time = Match.captured(11).toInt()*60000 + Match.captured(12).toInt()*1000+Match.captured(14).toInt();   //获取每一句歌词的时间

            m_time.push_back(time);
        }

    }
}
