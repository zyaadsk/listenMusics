#ifndef KUGOU_H
#define KUGOU_H
#include <QNetworkAccessManager>
#include <QNetworkReply>

class KuGou : public QObject {
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

 signals:
  void mediaAdd(QString play_urlStr);
};

#endif  // KUGOU_H
