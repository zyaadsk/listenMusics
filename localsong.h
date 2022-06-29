#ifndef LOCALSONG_H
#define LOCALSONG_H

#include <QObject>
#include <QVariantMap>

class LocalSong : public QObject
{
    Q_OBJECT
public:
    explicit LocalSong(QObject *parent = nullptr);

    Q_INVOKABLE void songInfo(QString url);

    const QVariantMap &Tags() const;
    void setTags(const QVariantMap &newTags);

signals:

    void TagsChanged();

private:
    QVariantMap m_Tags;

    Q_PROPERTY(QVariantMap Tags READ Tags WRITE setTags NOTIFY TagsChanged)
};

#endif // LOCALSONG_H
