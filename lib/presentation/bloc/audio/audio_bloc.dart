import 'package:big_apple/domain/usecases/is_music_enabled_usecase.dart';
import 'package:big_apple/domain/usecases/is_sound_enabled_usecase.dart';
import 'package:big_apple/domain/usecases/set_music_enabled_usecase.dart';
import 'package:big_apple/domain/usecases/set_sound_enabled_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

part 'audio_event.dart';
part 'audio_state.dart';

@Injectable()
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc(
    this._isMusicEnabledUseCase,
    this._isSoundEnabledUseCase,
    this._setMusicEnabledUseCase,
    this._setSoundEnabledUseCase,
  ) : super(const AudioInitialState()) {
    on<AudioInitEvent>(_init, transformer: restartable());
    on<AudioToggleMusicEnabledEvent>(_toggleMusicEnabled, transformer: restartable());
    on<AudioToggleSoundEnabledEvent>(_toggleSoundEnabled, transformer: restartable());
  }

  final IsMusicEnabledUseCase _isMusicEnabledUseCase;
  final IsSoundEnabledUseCase _isSoundEnabledUseCase;
  final SetMusicEnabledUseCase _setMusicEnabledUseCase;
  final SetSoundEnabledUseCase _setSoundEnabledUseCase;

  void _init(
    AudioInitEvent event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(
        AudioLoadingState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );

      final isMusicEnabled = _isMusicEnabledUseCase.call();
      final isSoundEnabled = _isSoundEnabledUseCase.call();

      emit(
        AudioLoadedState(
          isMusicEnabled: isMusicEnabled,
          isSoundEnabled: isSoundEnabled,
        ),
      );
    } catch (e) {
      emit(
        AudioFailureState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );
    }
  }

  void _toggleMusicEnabled(
    AudioToggleMusicEnabledEvent event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(
        AudioLoadingState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );

      await _setMusicEnabledUseCase.call(!state.isMusicEnabled);
      final isMusicEnabled = _isMusicEnabledUseCase.call();

      emit(
        AudioLoadedState(
          isMusicEnabled: isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );
    } catch (e) {
      emit(
        AudioFailureState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );
    }
  }

  void _toggleSoundEnabled(
    AudioToggleSoundEnabledEvent event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(
        AudioLoadingState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );

      await _setSoundEnabledUseCase.call(!state.isSoundEnabled);
      final isSoundEnabled = _isSoundEnabledUseCase.call();

      emit(
        AudioLoadedState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: isSoundEnabled,
        ),
      );
    } catch (e) {
      emit(
        AudioFailureState(
          isMusicEnabled: state.isMusicEnabled,
          isSoundEnabled: state.isSoundEnabled,
        ),
      );
    }
  }
}
