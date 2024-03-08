import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:big_apple/di/injector.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies(String environment) => GetIt.instance.$initGetIt(environment: environment);

T inject<T extends Object>({
  String? instanceName,
  dynamic param1,
  dynamic param2,
  Type? type,
}) =>
    GetIt.I.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
