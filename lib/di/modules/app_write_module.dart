import 'package:appwrite/appwrite.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppWriteModule {
  @singleton
  Client buildAppWriteClient() {
    Client client = Client();
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('big-apple').setSelfSigned(status: true);
    return client;
  }
}
