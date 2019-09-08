import 'bloc_injector.dart';
import 'bloc_module.dart';

class ContainerDI {
  static BlocInjector _container;

  static Future<void> initialize() async {
    if (_container == null) {
      _container = await BlocInjector.create(BlocModule());
    }
  }

  static BlocInjector get container {
    return _container;
  }
}
