import 'package:big_apple/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SetSoundEnabledUseCase {
  SetSoundEnabledUseCase(this._audioRepository);

  final AudioRepository _audioRepository;

  Future<bool> call(bool isEnabled) => _audioRepository.setSoundEnabled(isEnabled);
}
