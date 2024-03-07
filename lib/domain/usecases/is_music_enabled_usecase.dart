import 'package:big_apple/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class IsMusicEnabledUseCase {
  IsMusicEnabledUseCase(this._audioRepository);

  final AudioRepository _audioRepository;

  bool call() => _audioRepository.isMusicEnabled();
}
