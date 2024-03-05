import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AudioDataProviderKeys {
  const _AudioDataProviderKeys._();

  static const musicEnabledKey = 'music_enabled_key';
  static const soundEnabledKey = 'sound_enabled_key';
}

@injectable
class AudioDataProvider {
  const AudioDataProvider(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  bool isMusicEnabled() {
    return _sharedPreferences.getBool(_AudioDataProviderKeys.musicEnabledKey) ?? true;
  }

  Future<bool> setMusicEnabled(bool isEnabled) async {
    try {
      return _sharedPreferences.setBool(_AudioDataProviderKeys.musicEnabledKey, isEnabled);
    } catch (e) {
      return false;
    }
  }

  bool isSoundEnabled() {
    return _sharedPreferences.getBool(_AudioDataProviderKeys.soundEnabledKey) ?? true;
  }

  Future<bool> setSoundEnabled(bool isEnabled) async {
    try {
      return _sharedPreferences.setBool(_AudioDataProviderKeys.soundEnabledKey, isEnabled);
    } catch (e) {
      return false;
    }
  }
}
