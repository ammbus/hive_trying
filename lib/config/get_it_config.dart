// get_it_config.dart
import 'package:get_it/get_it.dart';
import 'package:trying_storing/service/bird_service.dart';

GetIt core = GetIt.instance;

init() {
  core.registerSingleton(BirdServiceImp());
}
