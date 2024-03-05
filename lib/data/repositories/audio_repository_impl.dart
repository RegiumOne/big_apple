import 'package:big_apple/data/datasources/local/data_providers/audio_data_provider.dart';
import 'package:big_apple/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AudioRepository)
class AudioRepositoryImpl implements AudioRepository {
  const AudioRepositoryImpl(this._audioDataProvider);

  final AudioDataProvider _audioDataProvider;

  @override
  bool isMusicEnabled() => _audioDataProvider.isMusicEnabled();

  @override
  Future<bool> setMusicEnabled(bool isEnabled) => _audioDataProvider.setMusicEnabled(isEnabled);

  @override
  bool isSoundEnabled() => _audioDataProvider.isSoundEnabled();

  @override
  Future<bool> setSoundEnabled(bool isEnabled) => _audioDataProvider.setSoundEnabled(isEnabled);
}
