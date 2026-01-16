import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  // TODO: implement apiHost
  String get apiHost => 'saheli-backend-kuuh.vercel.app';

  @override
  // TODO: implement useHttps
  bool get useHttps => false;
}
