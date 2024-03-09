part of 'audio_bloc.dart';

abstract class AudioState {
  const AudioState({
    required this.isMusicEnabled,
    required this.isSoundEnabled,
  });

  final bool isMusicEnabled;
  final bool isSoundEnabled;
}

class AudioInitialState extends AudioState {
  const AudioInitialState({
    super.isMusicEnabled = true,
    super.isSoundEnabled = true,
  });
}

class AudioLoadingState extends AudioState {
  const AudioLoadingState({
    required super.isMusicEnabled,
    required super.isSoundEnabled,
  });
}

class AudioLoadedState extends AudioState {
  const AudioLoadedState({
    required super.isMusicEnabled,
    required super.isSoundEnabled,
  });
}

class AudioCheckMusicState extends AudioState {
  const AudioCheckMusicState({
    required super.isMusicEnabled,
    required super.isSoundEnabled,
  });
}

class AudioFailureState extends AudioState {
  const AudioFailureState({
    required super.isMusicEnabled,
    required super.isSoundEnabled,
  });
}
