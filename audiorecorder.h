#ifndef AUDIORECORDER_H
#define AUDIORECORDER_H

#include <QAudioFormat>
#include <QAudioInput>
#include <QAudioOutput>
#include <QFile>
#include <QWidget>

class AudioRecorder : public QWidget {
  Q_OBJECT
 public:
  explicit AudioRecorder(QWidget *parent = nullptr);

  Q_INVOKABLE void startRecord(QString dirPath);
  Q_INVOKABLE void stopRecord();
  Q_INVOKABLE void play();
  Q_INVOKABLE void save(QString filename);
  Q_INVOKABLE void pause();

 private:
  int AddWavHeader(char *);
  int ApplyVolumeToSamle(short sample);
  void InitMonitor();
  void CreateAudioInput();
  void CreateAudioOutput();

  // QAudioFormat类存储音频流参数信息
  QAudioFormat m_formatFile;
  // QFile类提供了一个读取和写入文件的接口
  QFile *m_outputFile;
  //表示音频的输入通道
  QAudioInput *m_audioInputFile;
  //表示音频的输出通道
  QAudioOutput *m_audioOutputFile;
  // QByteArray类提供了一个字节数组
  QByteArray m_Buffer;
  QString m_filePath;

 signals:
};

#endif  // AUDIORECORDER_H
