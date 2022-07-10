/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

#ifndef LYRIC_H
#define LYRIC_H

#include <QObject>

class Lyric : public QObject
{
    Q_OBJECT
private:
    QVector<QString> m_onelineLyric;//歌词
    QVector<int> m_time; //时间
    QString m_lyric; //所有歌词
    QString m_localFileUrl;     //本地歌词路径

    Q_PROPERTY(QVector<QString> onelineLyric READ onelineLyric WRITE setOnelineLyric NOTIFY onelineLyricChanged)

    Q_PROPERTY(QVector<int> time READ time WRITE setTime NOTIFY timeChanged)


public:
    explicit Lyric(QObject *parent = nullptr);

    Q_INVOKABLE void divideLyrics();    //获取歌词文件中的每一行歌词，并存入m_onelineLyric，时间存入中m_time
    Q_INVOKABLE void divideLocalLyric();    //解析本地文件的歌词

    QString getLyric(){return m_lyric;}
    Q_INVOKABLE void setLyric(QString lyric){m_lyric=lyric;}    //获取搜索的歌词

    const QVector<QString> &onelineLyric() const;
    void setOnelineLyric(const QVector<QString> &newOnelineLyric);

    const QVector<int> &time() const;
    void setTime(const QVector<int> &newTime);

    Q_INVOKABLE void getLocalUrl(QString fileUrl){m_localFileUrl = fileUrl;}  //获取本地歌词路径

signals:

    void onelineLyricChanged();
    void timeChanged();
};

#endif // LYRIC_H
