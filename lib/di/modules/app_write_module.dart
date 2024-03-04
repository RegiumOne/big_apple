import 'package:appwrite/appwrite.dart';
import 'package:big_apple/common/environments/app_environment.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppWriteModule {
  @singleton
  Client buildAppWriteClient(AppEnvironment environment) {
    Client client = Client();
    client.setEndpoint(environment.host).setProject(environment.project).setSelfSigned(status: true);
    return client;
  }

  @singleton
  Account getAccount(Client client) => Account(client);
}
