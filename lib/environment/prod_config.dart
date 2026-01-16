import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  // TODO: implement apiHost
  String get apiHost => 'jhah.conurets.com/jhah-user';

  @override
  // TODO: implement useHttps
  bool get useHttps => true;
}
