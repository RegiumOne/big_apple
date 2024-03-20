import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum AudioFile {
  positiveNotificationNewLevel,
  forest,
  riverStream,
  constructionSounds,
  recordingOfBusyNewYork,
  streetAmbience,
  mouseClick,
  town1,
  town2,
  town3,
  town4,
  town5;

  String get assetsPath {
    String assets = '';
    switch (this) {
      case positiveNotificationNewLevel:
        assets = Assets.audio.positiveNotificationNewLevel;
        break;
      case town1:
        assets = Assets.audio.town1;
        break;
      case town2:
        assets = Assets.audio.town2;
        break;
      case town3:
        assets = Assets.audio.town3;
        break;
      case town4:
        assets = Assets.audio.town4;
        break;
      case town5:
        assets = Assets.audio.town5;
        break;
      case streetAmbience:
        assets = Assets.audio.streetAmbience;
        break;
      case recordingOfBusyNewYork:
        assets = Assets.audio.recordingOfBusyNewYorkCityStreet;
        break;
      case forest:
        assets = Assets.audio.forestWithSmallRiverBirdsAndNatureFieldRecording;
        break;
      case riverStream:
        assets = Assets.audio.riverStreamModerateFlow;
        break;
      case constructionSounds:
        assets = Assets.audio.constructionSoundscapeWithReverb;
        break;
      default:
        assets = Assets.audio.mouseClick;
    }
    return assets.removeAssetsAudioPath();
  }

  static List<AudioFile> get backgroundTracks => [
        town1,
        town2,
        town3,
        town4,
        town5,
      ];

  static List<AudioFile> get popupWindowTracks => [
        recordingOfBusyNewYork,
        streetAmbience,
      ];
}
