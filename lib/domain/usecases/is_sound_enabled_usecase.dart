import 'package:big_apple/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class IsSoundEnabledUseCase {
  IsSoundEnabledUseCase(this._audioRepository);

  final AudioRepository _audioRepository;

  bool call() => _audioRepository.isSoundEnabled();
}
