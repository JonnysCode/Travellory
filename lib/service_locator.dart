import 'package:get_it/get_it.dart';
import 'package:travellory/services/navigation_service.dart';

GetIt locator = GetIt();

// register NavigationService with the locator
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}