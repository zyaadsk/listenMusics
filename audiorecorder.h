#ifndef AUDIORECORDER_H
#define AUDIORECORDER_H

#include <QAudioFormat>
#include <QWidget>

class Audiorecorder : public QWidget {
  Q_OBJECT
 public:
  explicit Audiorecorder(QWidget *parent = nullptr);

 private:
  QAudioFormat mFormatFile;

 signals:
};

#endif  // AUDIORECORDER_H
