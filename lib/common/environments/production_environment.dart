import 'package:big_apple/common/environments/app_environment.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppEnvironment)
@prod
class ProductionEnvironment implements AppEnvironment {
  @override
  String host = "https://cloud.appwrite.io/v1";

  @override
  String project = 'big-apple';
}
