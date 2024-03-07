import 'dart:async';
import 'dart:math' as math;

import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioService {
  AudioService._internal();

  static const double _soundVolume = 0.1;

  static const double _initialBackgroundMusicVolume = 0.0;
  static const double _targetBackgroundMusicVolume = 0.1;
  static const double _mutedBackgroundMusicVolume = _targetBackgroundMusicVolume / 4;

  static const double _targetSecondaryMusicVolume = 0.4;

  static const double _volumeMusicStep = 0.001;
  static const int _volumeMusicChangeDelay = 100;

  static final AudioService _instance = AudioService._internal();

  static AudioService get instance => _instance;

  bool _isEnabledMusic = false;
  bool _isEnabledSound = false;

  AudioFile? _lastPlayedTrack;

  final math.Random _random = math.Random();

  StreamSubscription? _onPlayerCompleteSub;

  AudioFile? _secondaryTrack;
  AudioPlayer? _secondaryPlayer;

  Future<void> initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(Assets.audio.values.map((e) => e.removeAssetsAudioPath()).toList());
    _onPlayerCompleteSub = FlameAudio.bgm.audioPlayer.onPlayerComplete.listen((event) {
      _fadeoutBackgroundMusic().then((_) => playMusic());
    });
  }

  Future<void> playSound(AudioFile sound) async {
    if (_isEnabledSound) {
      await FlameAudio.play(sound.assetsPath, volume: _soundVolume);
    }
  }

  Future<void> playMusic() async {
    if (!_isEnabledMusic) return;

    _background();
  }

  Future<void> playForestMusic() async {
    if (!_isEnabledMusic) return;
    if (_secondaryTrack == AudioFile.forest) return;
    await _playSecondaryMusic(AudioFile.forest);
  }

  Future<void> playRiverStreamMusic() async {
    if (!_isEnabledMusic) return;
    if (_secondaryTrack == AudioFile.riverStream) return;
    await _playSecondaryMusic(AudioFile.riverStream);
  }

  Future<void> playConstructionMusic() async {
    if (!_isEnabledMusic) return;
    if (_secondaryTrack == AudioFile.constructionSounds) return;
    await _playSecondaryMusic(AudioFile.constructionSounds);
  }

  Future<void> playPopupWindowMusic() async {
    if (!_isEnabledMusic) return;

    final AudioFile randomTrack = AudioFile.popupWindowTracks[_random.nextInt(AudioFile.popupWindowTracks.length)];

    await _playSecondaryMusic(randomTrack);
  }

  Future<void> _playSecondaryMusic(AudioFile track) async {
    if (!_isEnabledMusic) return;

    _secondaryTrack = track;

    await FlameAudio.bgm.audioPlayer.setVolume(_mutedBackgroundMusicVolume);

    await _secondaryPlayer?.stop();
    await _secondaryPlayer?.dispose();
    _secondaryPlayer = await FlameAudio.loop(track.assetsPath, volume: _targetSecondaryMusicVolume);
  }

  Future<void> _background() async {
    FlameAudio.bgm.audioPlayer.setVolume(_initialBackgroundMusicVolume);

    final backgroundTracks = AudioFile.backgroundTracks;

    AudioFile track;
    do {
      track = backgroundTracks[_random.nextInt(backgroundTracks.length)];
    } while (backgroundTracks.length > 1 && track == _lastPlayedTrack);

    await FlameAudio.bgm.play(track.assetsPath, volume: _initialBackgroundMusicVolume);
    _lastPlayedTrack = track;

    await _fadeinBackgroundMusic();
  }

  Future<void> _fadeinBackgroundMusic() async {
    for (double i = _initialBackgroundMusicVolume; i <= _mutedBackgroundMusicVolume; i += _volumeMusicStep) {
      await Future.delayed(const Duration(milliseconds: _volumeMusicChangeDelay));
      FlameAudio.bgm.audioPlayer.setVolume(i);
    }
  }

  Future<void> _fadeoutBackgroundMusic() async {
    for (double i = _mutedBackgroundMusicVolume; i >= _initialBackgroundMusicVolume; i -= _volumeMusicStep) {
      await Future.delayed(const Duration(milliseconds: _volumeMusicChangeDelay));
      FlameAudio.bgm.audioPlayer.setVolume(i);
    }
  }

  Future<void> setMusicEnabled(bool isEnabled) async {
    _isEnabledMusic = isEnabled;
    if (!_isEnabledMusic) {
      await pauseMusic();
    } else {
      if (FlameAudio.bgm.audioPlayer.source != null) {
        await resumeMusic();
      } else {
        await playMusic();
      }
    }
  }

  void setSoundEnabled(bool isEnabled) {
    _isEnabledSound = isEnabled;
  }

  Future<void> pauseMusic() async {
    await FlameAudio.bgm.pause();
    await _secondaryPlayer?.pause();
  }

  Future<void> resumeMusic() async {
    await FlameAudio.bgm.resume();
    await _secondaryPlayer?.resume();
  }

  Future<void> stopMusic() async {
    await FlameAudio.bgm.stop();
    await _secondaryPlayer?.stop();
  }

  void dispose() {
    stopMusic();
    _onPlayerCompleteSub?.cancel();
    _onPlayerCompleteSub = null;
    FlameAudio.bgm.dispose();
    _secondaryPlayer?.dispose();
  }
}
