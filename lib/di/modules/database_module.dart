import 'package:injectable/injectable.dart';

import 'package:big_apple/data/datasources/local/database/app_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get appDatabase;
}
