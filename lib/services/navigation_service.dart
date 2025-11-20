import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' show MaterialWithModalsPageRoute;

import '../constant/route_name.dart';
import '../models/food.dart';
import '../repositories/user_repository.dart';
import '../screens/authentication/authentication_view.dart';
import '../screens/checkout/checkout_view.dart';
import '../screens/food_detail/food_detail.dart';
import '../screens/onboard/onboard_view.dart';
import '../screens/overview/overview.dart';
import 'get_it.dart';
enum NavigationBarType { tabNavigator, cart }

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  UserRepository userRepo = locate<UserRepository>();

  ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);
  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);
  ValueNotifier<NavigationBarType> showNavigationBarType =
      ValueNotifier<NavigationBarType>(NavigationBarType.tabNavigator);

  List<String> pathToCloseNavigationBar = [
    authPath,
    welcomePath,
    cartPath,
  ];

  void setNavigationBar(bool value, [NavigationBarType navigationBarType = NavigationBarType.tabNavigator]) {
    showNavigationBar.value = value;
    showNavigationBarType.value = navigationBarType;
    showNavigationBar.notifyListeners();
  }

  void updateIndex(int value) {
    currentIndexNotifier.value = value;
    currentIndexNotifier.value = value;

    if (value == currentIndexNotifier.value) return;
    currentIndexNotifier.notifyListeners();
  }

  String determineHomePath() {
    if (userRepo.currentUserUID != null) {
      return overviewPath;
    }
    return welcomePath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    final routeName = settings.name;
    switch (routeName) {
      case authPath:
        final state = settings.arguments as AuthenticationViewState;
        return _navigateToModelPageRoute(settings, AuthenticationView(viewState: state));
      case welcomePath:
        return _navigateToModelPageRoute(settings, const OnboardView());

      case overviewPath:
        return _navigateToModelPageRoute(settings, const Overview());

      case cartPath:
        return _navigateToModelPageRoute(settings, const CheckoutView());

      case foodDetailPath:
        final food = settings.arguments as Food?;

        return _navigateToModelPageRoute(
          settings,
          FoodDetailViewWidget(food: food!),
        );
    }

    return null;
  }

  PageRoute navigateToMaterialPageRoute(RouteSettings settings, Widget page,
      {bool maintainState = true, bool fullscreenDialog = false}) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => page,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  MaterialPageRoute _navigateToModelPageRoute(RouteSettings settings, Widget child,
      {bool maintainState = true, bool fullscreenDialog = false}) {
    return MaterialWithModalsPageRoute(
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      builder: (_) => child,
    );
  }
}

class TabNavigationObservers extends RouteObserver<PageRoute<dynamic>> {
  TabNavigationObservers();

  final navigationService = locate<NavigationService>();

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final containPreviousRoutePath = navigationService.pathToCloseNavigationBar.contains(previousRoute?.settings.name);

    if (containPreviousRoutePath) {
      navigationService.setNavigationBar(false);
    }

    if (!containPreviousRoutePath) {
      navigationService.setNavigationBar(true);
    }

    super.didPop(route!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final paths = navigationService.pathToCloseNavigationBar;
    final containRoutePath = paths.contains(route.settings.name);

    if (containRoutePath) {
      navigationService.setNavigationBar(false);
    } else {
      navigationService.setNavigationBar(
          true, route.settings.name == foodDetailPath ? NavigationBarType.cart : NavigationBarType.tabNavigator);
    }

    super.didPush(route, previousRoute);
  }
}
