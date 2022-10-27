import 'dart:io';
import 'dart:ui';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/log_callback.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/media_information_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:ffmpeg_kit_flutter/statistics_callback.dart';

import 'video_attribute.dart';
import 'video_offset.dart';

class VideoEditFactoryMyClass {
  final String inputPath;

  late VideoAttribute _videoAttribute;

  VideoEditFactoryMyClass({required this.inputPath}) {
    _videoAttribute = new VideoAttribute();
    _videoAttribute.inputPath = inputPath;
  }

  executeAsyncShortVideo1({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toShort1(), executeCallback,
        logCallback, statisticsCallback);
  }
  executeAsyncShortVideo2({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toShort2(), executeCallback,
        logCallback, statisticsCallback);
  }
  executeAsyncShortVideo3({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toShort3(), executeCallback,
        logCallback, statisticsCallback);
  }
  // executeAsyncShortVideo4({
  //   FFmpegSessionCompleteCallback? executeCallback,
  //   LogCallback? logCallback,
  //   StatisticsCallback? statisticsCallback,
  // }) async {
  //   await FFmpegKit.executeAsync(_videoAttribute.toShort4(), executeCallback,
  //       logCallback, statisticsCallback);
  // }
  // executeAsyncShortVideo5({
  //   FFmpegSessionCompleteCallback? executeCallback,
  //   LogCallback? logCallback,
  //   StatisticsCallback? statisticsCallback,
  // }) async {
  //   await FFmpegKit.executeAsync(_videoAttribute.toShort5(), executeCallback,
  //       logCallback, statisticsCallback);
  // }
  executeAsyncConcat({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toConcat(), executeCallback,
        logCallback, statisticsCallback);
  }

  videoPreviewImage({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
    int timeFrame = 1,
    Size? size,
  }) async {
    await FFmpegKit.executeAsync(
        _videoAttribute.getVideoPreviewImage(
          timeFrame: timeFrame,
          size: size,
        ),
        executeCallback,
        logCallback,
        statisticsCallback);
  }

  cancel() {
    FFmpegKit.cancel();
  }

  Future<File> getVideoFirstFrame() async {
    File file = new File("path");

    return file;
  }

  Future<MediaInformationSession> getMediaInfo({
    MediaInformationSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
  }) async {
    return FFprobeKit.getMediaInformationAsync(
        inputPath, executeCallback, logCallback, _videoAttribute.waitTimeOut);
  }

  static Future<MediaInformationSession> getMediaInfoStatic(
      String inputPath, {
        MediaInformationSessionCompleteCallback? executeCallback,
        LogCallback? logCallback,
        int timeOut = 9999,
      }) async {
    return await FFprobeKit.getMediaInformationAsync(
        inputPath, executeCallback, logCallback, timeOut);
  }

  Future<File> getOutputFileShortVideo1(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputShortVideoPath1}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }
  Future<File> getOutputFileShortVideo2(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputShortVideoPath2}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }
  Future<File> getOutputFileShortVideo3(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputShortVideoPath3}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }
  // Future<File> getOutputFileShortVideo4(Session session) async {
  //   SessionState sessionState = await session.getState();
  //   if (SessionState.completed == sessionState) {
  //     return new File("${_videoAttribute.outputShortVideoPath4}");
  //   } else {
  //     throw new VEException('${sessionState.toString()}', session: session);
  //   }
  // }
  // Future<File> getOutputFileShortVideo5(Session session) async {
  //   SessionState sessionState = await session.getState();
  //   if (SessionState.completed == sessionState) {
  //     return new File("${_videoAttribute.outputShortVideoPath5}");
  //   } else {
  //     throw new VEException('${sessionState.toString()}', session: session);
  //   }
  // }
  Future<File> getOutputConcatVideoPath(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputConcatVideoPath}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }


  Future<File> getVideoPreviewImage(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputImagePath}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }

  /// 设置文件的输出目录
  /// Set the output directory of the file
  setOutputPath(String outputPath) {
    _videoAttribute.outputPath = outputPath;
  }

  setInputPathForShortVideo(String inputPathForSV) {
    _videoAttribute.outputPath = inputPathForSV;
  }

  setInputPathForConcat(String inputPathFC) {
    _videoAttribute.outputPath = inputPathFC;
  }

  /// 剪切视频指定区间（单位：秒）
  /// Cut video specified interval (unit: second)
  cutByTime(int start, int end) {
    _videoAttribute.cutByTime = "-ss $start -to $end";
  }

  /// 设置超时时间（仅限获取文件信息时生效）
  /// Set the timeout period (valid only when the file information is obtained)
  setTimeOut(int second) {
    _videoAttribute.waitTimeOut = second;
  }

  /// 设置输出文件名称
  /// Set the output file name
  setOutputName(String name) {
    _videoAttribute.name = name;
  }

  /// 设置视频帧数
  /// Set the number of video frames
  setOutPutFPS(int fps) {
    _videoAttribute.fps = "-r $fps ";
  }

  /// 设置输出文件的大小
  /// Set the size of the output file
  setOutputVideoSize(int mb) {
    _videoAttribute.size = "-fs ${mb}MB ";
  }

  /// 设置视频比特率
  /// Set video bit rate
  setBitRate(double mb) {
    _videoAttribute.bitRate = "-b:v ${mb}M ";
  }

  /// 设置输出格式
  /// Set output format
  setType(String type) {
    _videoAttribute.videoType = type;
  }


  setShortVideo1() {
    _videoAttribute.shortVideo1 = "-ss 0 -t 2";
  }
  setShortVideo2() {
    _videoAttribute.shortVideo2 = "-ss 2 -t 2";
  }
  setShortVideo3() {
    _videoAttribute.shortVideo3 = "-ss 4 -t 2";
  }
  // setShortVideo4() {
  //   _videoAttribute.shortVideo4 = "-ss 6 -t 2";
  // }
  // setShortVideo5() {
  //   _videoAttribute.shortVideo4 = "-ss 8 -t 2";
  // }


  setMixTimeShortVideoSlow() {
    _videoAttribute.mixTimeShortVideoSlow = "-filter:v 'setpts=2*PTS'";
  }
  setMixTimeShortVideoFast() {
    _videoAttribute.mixTimeShortVideoFast = "-filter:v 'setpts=0.5*PTS'";
  }
  // setMixTimeShortVideo3() {
  //   _videoAttribute.mixTimeShortVideo3 = "-i shortVideo3.mp4 -filter:v 'setpts=0.5*PTS' part-3.mp4";
  // }


  setConcatVideo() {
    _videoAttribute.concatVideo = "-filter_complex '[0:0] [0:1] [0:2] [1:0] [1:1] [1:2] [2:0] [2:1] [2:2] concat=n=3:v=1:a=2 [v] [a1] [a2]' -map '[v]' -map '[a1]' -map '[a2]'";
  }



  /// 设置输出文件的宽高
  /// Set the width and height of the output file
  setOutputVideoSale(int width, int height) {
    if (height == -1) {
      _videoAttribute.outputSize = "sale=$width:-1 ";
    } else if (width == -1) {
      _videoAttribute.outputSize = "sale=-1:$height ";
    } else {
      _videoAttribute.outputSize = "-s ${width}x$height ";
    }
  }

  /// 设置图片水印
  /// Set image watermark
  setPictureWatermark(File pictureFile, VideoOffset offset) {
    _videoAttribute.addWaterMark =
    "-vf \"movie= ${pictureFile.path} ${offset.toString()}\" ";
  }
}


class VEException implements Exception {
  final Session session;
  final String message;

  VEException(
      this.message, {
        required this.session,
      });

  @override
  String toString() {
    return "${session.toString()}:$message";
  }
}