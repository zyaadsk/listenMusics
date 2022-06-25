#include "decode.h"

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/dict.h>
#include <libavutil/samplefmt.h>
#include <libswresample/swresample.h>
}

#include <QDebug>

Decode::Decode(QObject *parent) : QObject{parent} {}

bool Decode::decode(QString filePath, QString dirPath) {
  // AVFormatContext:用来存储视音频封装格式（flv，mp4，rmvb，avi）中包含的所有信息
  // 很多函数都要用到它作为参数。
  // avformat_free_context()可以用来释放该Context，并且会释放由框架分配的所有内存
  AVFormatContext *pFormat = avformat_alloc_context();
  QByteArray temp = filePath.toUtf8();
  const char *path = temp.constData();
  QString out = dirPath + "/out.pcm";
  QByteArray ou = out.toUtf8();
  const char *output = ou.constData();

  //  参数说明：
  //  AVFormatContext *ps,
  //  格式化的上下文。要注意，如果传入的是一个AVFormatContext*的指针，则该空间须自己手动清理，若传入的指针为空，则FFmpeg会内部自己创建。
  //  const char *filename,
  //  传入的文件地址。支持http,RTSP,以及普通的本地文件。地址最终会存入到AVFormatContext结构体当中。
  //  AVInputFormat *fmt, 指定输入的封装格式。一般传NULL，由FFmpeg自行探测。
  //  AVDictionary **options,
  //  其它参数设置。它是一个字典，用于参数传递，不传则写NULL
  // return 成功时返回 0，失败时返回负的 AVERROR
  int ret = avformat_open_input(&pFormat, path, NULL, NULL);
  if (ret != 0 || pFormat == NULL) {
    qDebug() << "无法打开文件！";
    return 0;
  }
  if (avformat_find_stream_info(pFormat, NULL) < 0) {
    qDebug() << "获取流信息失败！";
    return 0;
  }
  int audio_stream_idx = -1;
  for (int i = 0; i < pFormat->nb_streams; i++) {
    if (pFormat->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_AUDIO) {
      audio_stream_idx = i;
      break;
    }
  }
  //编码器
  AVCodecParameters *codecpar = pFormat->streams[audio_stream_idx]->codecpar;
  //解码器
  AVCodec *dec =
      const_cast<AVCodec *>(avcodec_find_decoder(codecpar->codec_id));
  AVCodecContext *codecContext = avcodec_alloc_context3(dec);
  avcodec_parameters_to_context(codecContext, codecpar);
  //对应的codeccontext⾃⼰对pkt_timebase设置和AVStream⼀样的time_base
  codecContext->pkt_timebase = pFormat->streams[audio_stream_idx]->time_base;
}
