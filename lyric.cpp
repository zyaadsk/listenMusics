#include "lyric.h"

#include <QRegularExpression>
#include <QRegularExpressionMatch>

#include <QDebug>

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

Lyric::Lyric(QObject *parent)
    : QObject{parent}
{

}

void Lyric::divideLyrics()
{
      getLyric();
      qDebug() <<"歌词：" <<m_lyric;

      QRegularExpression rex("\\[(id)?(hash)?(sign)?(qq)?(total)?"
                             "(ar)?(ti)?(al)?(by)?(offset)?(\\d+)?:(\\d+)?(\\.\\d+)?(\\S+)?\\]");
      QRegularExpressionMatch Match;

      //将歌词按行分解为歌词列表
      QStringList lines = m_lyric.split("\r\n");

      foreach(QString oneline,lines){

//          int t = oneline.mid(1,2).toInt();
          Match = rex.match(oneline);

          QString currentLyric;
          int time;


//          if(t>=0||t<=9){
//              time = Match.captured(11).toInt()*60000 + Match.captured(12).toInt()*1000+Match.captured(14).toInt();
//              m_time.push_back(time);
//              qDebug() << time;
//          }

          currentLyric = QString(oneline).right(QString(oneline).length()-Match.capturedLength());
          if(currentLyric!=""&&currentLyric!="]"){
              m_onelineLyric.push_back(currentLyric);

//              int min = oneline.mid(1,2).toInt();
//              int sec = oneline.mid(4,2).toInt();
//              int secs = oneline.mid(7,2).toInt();
//              int time = min*6000+sec*1000+secs;

              time = Match.captured(11).toInt()*60000 + Match.captured(12).toInt()*1000+Match.captured(14).toInt();

              m_time.push_back(time);
          }

//          qDebug() << "Lyric "<< currentLyric;
//          qDebug() << time;

//          QString temp = oneline;
//          temp.replace(rex,"");
//          qDebug() << temp;

//          if(temp!=""&&temp!="]"){
//              m_onelineLyric.push_back(temp);
//          }

//          int min = oneline.mid(1,2).toInt();
//          int sec = oneline.mid(4,2).toInt();
//          int secs = oneline.mid(7,2).toInt();
//          int time = min*6000+sec*1000+secs;

//          qDebug()<<time;

//          m_time.push_back(time);

      }
}

//int Lyric::getLyricIndex()
//{
//    getPosition();

//}
