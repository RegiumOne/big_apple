import 'package:injectable/injectable.dart';

import 'package:big_apple/common/components/environments/app_environment.dart';

@prod
@LazySingleton(as: AppEnvironment)
class ProductionEnvironment implements AppEnvironment {
  @override
  String host = "https://cloud.appwrite.io/v1";

  @override
  String project = 'big-apple';
}
