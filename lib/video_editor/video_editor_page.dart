//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/media_information.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';



import 'video_attribute.dart';
import 'video_offset.dart';
import 'video_edit_factory.dart';


class VideoEditorPage extends StatefulWidget {
  const VideoEditorPage({Key? key,  required this.file}) : super(key: key);

  final File file;

  @override
  State<VideoEditorPage> createState() => _VideoEditorPageState();
}

class _VideoEditorPageState extends State<VideoEditorPage> {
  List<String> videos = [];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    print(widget.file.path);
    print(p.absolute(widget.file.path));
    print(await _localPath);
  }

  void videoEdit() {
    VideoEditFactoryMyClass videoEditFactory = new VideoEditFactoryMyClass(
        inputPath: widget.file.path
    );
    videoEditFactory.getMediaInfo(executeCallback: (Session session) {
      MediaInformationSession mediaInformationSession =
      session as MediaInformationSession;

      MediaInformation? mediaInformation =
      mediaInformationSession.getMediaInformation();
    });
    File previewImage;
    videoEditFactory.videoPreviewImage(executeCallback: (Session session) async {
      await videoEditFactory
          .getVideoPreviewImage(session)
          .then((value) => previewImage = value);
    });

    videoEditFactory
      ..setType('mp4')
      ..setOutputName('output')
      ..setOutputPath('/sdcard/Download')
      ..setOutPutFPS(30)
      ..setBitRate(5)
      ..setInputPathForShortVideo('/sdcard/Download')
      ..setInputPathForConcat('/sdcard/Download')
      ..setShortVideo1()
      ..setShortVideo2()
      ..setShortVideo3()
    // ..setShortVideo4()
    // ..setShortVideo5()
      ..setMixTimeShortVideoSlow()
      ..setMixTimeShortVideoFast()
      ..setConcatVideo();

    File videoFile;

    videoEditFactory.executeAsyncShortVideo1(executeCallback: (Session session) async {
      await videoEditFactory.getOutputFileShortVideo1(session).then((value) => videoFile = value);
    });
    videoEditFactory.executeAsyncShortVideo2(executeCallback: (Session session) async {
      await videoEditFactory.getOutputFileShortVideo2(session).then((value) => videoFile = value);
    });
    videoEditFactory.executeAsyncShortVideo3(executeCallback: (Session session) async {
      await videoEditFactory.getOutputFileShortVideo3(session).then((value) => videoFile = value);
    });
    // videoEditFactory.executeAsyncShortVideo4(executeCallback: (Session session) async {
    //   await videoEditFactory.getOutputFileShortVideo4(session).then((value) => videoFile = value);
    // });
    // videoEditFactory.executeAsyncShortVideo5(executeCallback: (Session session) async {
    //   await videoEditFactory.getOutputFileShortVideo5(session).then((value) => videoFile = value);
    // });
    videoEditFactory.executeAsyncConcat(executeCallback: (Session session) async {
      final returnCode = await session.getReturnCode();
      await videoEditFactory.getOutputConcatVideoPath(session).then((value) => videoFile = value);
      if (ReturnCode.isSuccess(returnCode)) {
        print(returnCode);
      } else if (ReturnCode.isCancel(returnCode)) {
        print(returnCode);
      } else {
        print(returnCode);
      }
    });
  }


  // void FFmExecute() {
  //   FFmpegKit.executeAsync('-i ${widget.file.path} -c:v mpeg4 fileOutput.mp4 ', (session) async{
  //     final returnCode = await session.getReturnCode();
  //     if (ReturnCode.isSuccess(returnCode)) {
  //       //Разбиение на отрезки
  //       FFmpegKit.execute("ffmpeg -i ${widget.file.path} -ss 00:00:00 -t 2 -c copy -map 0 -start_at_zero test.mp4");
  //       FFmpegKit.execute('ffmpeg -i ${widget.file.path} -ss 00:00:02 -t 2 -c copy -map 0 -start_at_zero test1.mp4');
  //       FFmpegKit.execute('ffmpeg -i ${widget.file.path} -ss 00:00:04 -t 2 -c copy -map 0 -start_at_zero test2.mp4');
  //       FFmpegKit.execute('ffmpeg -i ${widget.file.path} -ss 00:00:06 -t 2 -c copy -map 0 -start_at_zero test3.mp4');
  //       FFmpegKit.execute('ffmpeg -i ${widget.file.path} -ss 00:00:08 -t 2 -c copy -map 0 -start_at_zero test4.mp4');
  //       //===========================================================================================================
  //       // ускорение и замедление фрагментов
  //       FFmpegKit.execute('ffmpeg -i test.mp4 -filter:v "setpts=0.5*PTS" part-1.mp4');
  //       FFmpegKit.execute('ffmpeg -i test1.mp4 -filter:v "setpts=2*PTS" part-2.mp4');
  //       FFmpegKit.execute('ffmpeg -i test2.mp4 -filter:v "setpts=0.5*PTS" part-3.mp4');
  //       FFmpegKit.execute('ffmpeg -i test3.mp4 -filter:v "setpts=2*PTS" part-4.mp4');
  //       FFmpegKit.execute('ffmpeg -i test4.mp4 -filter:v "setpts=0.5*PTS" part-5.mp4');
  //       //===================================================================================================
  //       //Конкатенация
  //       FFmpegKit.execute('ffmpeg -f concat -safe 0 -i myList2.txt -c copy fileOutput.mp4');
  //
  //     }else if (ReturnCode.isCancel(returnCode)) {
  //       print('returnCode not found');
  //
  //     }else {
  //       print('erorr');
  //
  //     }
  //   });
  //   print('FFmExecute end');
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (() => print(widget.file.path)),
              child: Text("get path"),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: (() => videoEdit()),
              child: Text("get short video and concat"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}



