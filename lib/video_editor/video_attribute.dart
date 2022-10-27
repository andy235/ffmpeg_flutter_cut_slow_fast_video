import 'dart:ui';

class VideoAttribute {
  VideoAttribute();

  String inputPath = "";

  String outputPath = "";

  String size = "";

  String videoType = "";

  String imageType = "jpg";

  String fps = "";

  String cutByTime = "";

  int waitTimeOut = 999;

  String name = "";

  String ShortVideoName1 = "ShortVideo1";
  String ShortVideoName2 = "ShortVideo2";
  String ShortVideoName3 = "ShortVideo3";
  // String ShortVideoName4 = "ShortVideo4";
  // String ShortVideoName5 = "ShortVideo5";

  String bitRate = "";

  String outputSize = "";

  String addWaterMark = "";

  String shortVideo1 = "";
  String shortVideo2 = "";
  String shortVideo3 = "";
  // String shortVideo4 = "";
  // String shortVideo5 = "";

  String mixTimeShortVideoSlow = "";
  String mixTimeShortVideoFast = "";

  String concatVideo = "";


  String get outputFilePath {
    return "$outputPath/$name.$videoType";
  }

  String get outputShortVideoPath1 {
    return "$outputPath/$ShortVideoName1.$videoType";
  }
  String get outputShortVideoPath2 {
    return "$outputPath/$ShortVideoName2.$videoType";
  }
  String get outputShortVideoPath3 {
    return "$outputPath/$ShortVideoName3.$videoType";
  }
  // String get outputShortVideoPath4 {
  //   return "$outputPath/$ShortVideoName4.$videoType";
  // }
  // String get outputShortVideoPath5 {
  //   return "$outputPath/$ShortVideoName5.$videoType";
  // }

  String get outputConcatVideoPath {
    return "$outputPath/$name.$videoType";
  }

  String get outputImagePath {
    return "$outputPath/$name.$imageType";
  }

  /// [size] : 在Android和iOS中可能会存在宽高相反的情况，
  /// 如果出现这种情况建议通过[Platform.isAndroid]/[Platform.isIOS]进行单独适配
  /// [size]: In Android and iOS, the width and height may be opposite,
  /// If this happens, it is recommended to use
  /// [Platform.is Android]/[Platform.is IOS] for individual adaptation
  String getVideoPreviewImage({int timeFrame = 1, Size? size}) {
    if (null != size) {
      return "-i $inputPath -ss $timeFrame -f image2 -s ${size.width}x${size.height} $outputImagePath";
    }
    return "-i $inputPath -ss $timeFrame -f image2 $outputImagePath";
  }

  @override
  String toShort1() {
    return "-i $inputPath $mixTimeShortVideoSlow $shortVideo1 $fps $bitRate $outputShortVideoPath1";
  }
  String toShort2() {
    return "-i $inputPath $mixTimeShortVideoFast $shortVideo2 $fps $bitRate $outputShortVideoPath2";
  }
  String toShort3() {
    return "-i $inputPath $mixTimeShortVideoSlow $shortVideo3 $fps $bitRate $outputShortVideoPath3";
  }
  // String toShort4() {
  //   return "-i $inputPath $mixTimeShortVideoFast $shortVideo4 $fps $bitRate $outputShortVideoPath4";
  // }
  // String toShort5() {
  //   return "-i $inputPath $mixTimeShortVideoSlow $shortVideo5 $fps $bitRate $outputShortVideoPath5";
  // }
  String toConcat() {
    return "-i $outputShortVideoPath1 -i $outputShortVideoPath2  -i $outputShortVideoPath3 $concatVideo $outputFilePath";
  }
}