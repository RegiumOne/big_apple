part of 'audio_bloc.dart';

abstract class AudioEvent {
  const AudioEvent();
}

class AudioInitEvent extends AudioEvent {
  const AudioInitEvent();
}

class AudioToggleMusicEnabledEvent extends AudioEvent {
  const AudioToggleMusicEnabledEvent();
}

class AudioToggleSoundEnabledEvent extends AudioEvent {
  const AudioToggleSoundEnabledEvent();
}
