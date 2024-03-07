abstract interface class AudioRepository {
  bool isMusicEnabled();

  Future<bool> setMusicEnabled(bool isEnabled);

  bool isSoundEnabled();

  Future<bool> setSoundEnabled(bool isEnabled);
}
