import 'package:get_it/get_it.dart';
import 'package:loginapp/authenticate.dart';

GetIt locator = GetIt.instance;

void setup()
{
  locator.registerLazySingleton<Authenticate>(() => Authenticate());
}