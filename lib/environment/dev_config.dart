import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  // TODO: implement apiHost
  String get apiHost => '192.168.18.249:3000';

  @override
  // TODO: implement useHttps
  bool get useHttps => false;

  // @override
  // // TODO: implement webSocketUrl
  // String get apiHostWebSocket => 'wss://jhah-web-dev.conurets.com/web-notification/websocket';
  // // https://jhah.conurets.com/
}
