/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

#ifndef KUGOU_H
#define KUGOU_H
#include <QNetworkAccessManager>
#include <QNetworkReply>

class KuGou : public QObject {
  Q_OBJECT
  Q_PROPERTY(QList<QString> albumId READ albumId WRITE setAlbumId NOTIFY
                 albumIdChanged)
  Q_PROPERTY(QList<QString> singerName READ singerName WRITE setSingerName
                 NOTIFY singerNameChanged)
  Q_PROPERTY(QList<QString> songName READ songName WRITE setSongName NOTIFY
                 songNameChanged)
  Q_PROPERTY(QList<QString> albumName READ albumName WRITE setAlbumName NOTIFY
                 albumNameChanged)
  Q_PROPERTY(QList<double> duration READ duration WRITE setDuration NOTIFY
                 durationChanged)
  Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
  Q_PROPERTY(QString lyrics READ lyrics WRITE setLyrics NOTIFY lyricsChanged)
  Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
  Q_PROPERTY(QString song READ song WRITE setSong NOTIFY songChanged)
  Q_PROPERTY(QString singer READ singer WRITE setSinger NOTIFY singerChanged)

 private:
  QNetworkAccessManager *network_manager;
  QNetworkAccessManager *network_manager2;
  QNetworkRequest *network_request;
  QNetworkRequest *network_request2;
  QList<QString> m_albumId;  //专辑的唯一标识符
  QList<QString> m_fileHash;
  QList<QString> m_albumName;  //专辑名
  QList<QString> m_songName;
  QList<QString> m_singerName;
  QList<double> m_duration;
  QString m_image;
  QString m_lyrics;
  QString m_url;
  QString m_song;
  QString m_singer;

 protected slots:
  void replyFinished(QNetworkReply *reply);
  void replyFinished2(QNetworkReply *reply);

 public:
  // Q_INVOKABLE 将此宏应用于成员函数的声明，以允许通过元对象系统调用它们
  Q_INVOKABLE void search(QString str);
  Q_INVOKABLE void onclickPlay(int index);

  void parseJson_getAlbumID(QString json);
  void parseJson_getplay_url(QString json);

  KuGou(QObject *parent = nullptr);

  QList<QString> albumId() const { return m_albumId; }
  QList<QString> singerName() const { return m_singerName; }
  QList<QString> songName() const { return m_songName; }
  QList<QString> albumName() const { return m_albumName; }
  QString url() const { return m_url; }
  QString lyrics() const { return m_lyrics; }
  QList<double> duration() const { return m_duration; }
  QString image() const { return m_image; }
  QString song() const { return m_song; }
  QString singer() const { return m_singer; }

 signals:
  void albumIdChanged(QList<QString> albumId);
  void singerNameChanged(QList<QString> singerName);
  void songNameChanged(QList<QString> songName);
  void albumNameChanged(QList<QString> albumName);
  void urlChanged(QString url);
  void lyricsChanged(QString lyrics);
  void durationChanged(QList<double> duration);
  void imageChanged(QString image);
  void songChanged(QString song);
  void singerChanged(QString singer);

 public slots:
  void setAlbumId(QList<QString> albumId) {
    if (m_albumId == albumId) return;

    m_albumId = albumId;
    emit albumIdChanged(m_albumId);
  }

  void setSingerName(QList<QString> singerName) {
    if (m_singerName == singerName) return;

    m_singerName = singerName;
    emit singerNameChanged(m_singerName);
  }

  void setSongName(QList<QString> songName) {
    if (m_songName == songName) return;

    m_songName = songName;
    emit songNameChanged(m_songName);
  }

  void setAlbumName(QList<QString> albumName) {
    if (m_albumName == albumName) return;

    m_albumName = albumName;
    emit albumNameChanged(m_albumName);
  }

  void setUrl(QString url) {
    if (m_url == url) return;

    m_url = url;
    emit urlChanged(m_url);
  }

  void setLyrics(QString lyrics) {
    if (m_lyrics == lyrics) return;

    m_lyrics = lyrics;
    emit lyricsChanged(m_lyrics);
  }

  void setDuration(QList<double> duration) {
    if (m_duration == duration) return;

    m_duration = duration;
    emit durationChanged(m_duration);
  }

  void setImage(QString image) {
    if (m_image == image) return;

    m_image = image;
    emit imageChanged(m_image);
  }

  void setSong(QString song) {
    if (m_song == song) return;

    m_song = song;
    emit songChanged(m_song);
  }

  void setSinger(QString singer) {
    if (m_singer == singer) return;

    m_singer = singer;
    emit songChanged(m_singer);
  }
};

#endif  // KUGOU_H
