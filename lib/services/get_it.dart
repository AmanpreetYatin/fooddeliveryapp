import 'package:fooddeliveryapp/exports.dart';
import 'package:get_it/get_it.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<NavigationService>(NavigationService());
    getIt.registerSingleton<FoodRepository>(FoodRepository());
    getIt.registerSingleton<CartRepository>(CartRepository());
    getIt.registerSingleton<OrderRepository>(OrderRepository());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
