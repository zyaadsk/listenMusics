/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

#ifndef LOCALSONG_H
#define LOCALSONG_H

#include <QObject>
#include <QVariantMap>

class LocalSong : public QObject
{
    Q_OBJECT
public:
    explicit LocalSong(QObject *parent = nullptr);

    Q_INVOKABLE void songInfo(QString url); //传入本地音乐的路径，在对其进行解析

    const QVariantMap &Tags() const;    //map保存歌曲名，歌手，专辑所对应的值
    void setTags(const QVariantMap &newTags);

signals:

    void TagsChanged();

private:
    QVariantMap m_Tags;

    Q_PROPERTY(QVariantMap Tags READ Tags WRITE setTags NOTIFY TagsChanged)
};

#endif // LOCALSONG_H
