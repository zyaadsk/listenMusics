#include "audiorecorder.h"

#include <QAudioDevice>

#define BufferSize 4096

AudioRecorder::AudioRecorder(QWidget *parent)
    : QWidget{parent}, m_Buffer(BufferSize, 0) {
  m_outputFile = NULL;
  m_audioInputFile = NULL;
  m_audioOutputFile = NULL;

  m_outputFile = new QFile();

  //采样频率。8kHz(电话)、44.1kHz(CD)、48kHz(DVD)
  m_formatFile.setSampleRate(44100);
  //通道个数。常见的音频有立体声(stereo)和单声道(mono)两种类型，立体声包含左声道和右声道。另外还有环绕立体声等其它不太常用的类型。
  m_formatFile.setChannelCount(2);
  m_formatFile.setSampleFormat(QAudioFormat::UInt8);
}

void AudioRecorder::startRecord(QString dirPath) {
  m_filePath = dirPath + "/record.raw";
  m_outputFile->setFileName(m_filePath);
}
