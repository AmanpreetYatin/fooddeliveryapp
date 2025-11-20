import 'package:fooddeliveryapp/exports.dart';

import '../components/cupertino_model_route.dart';

class OverviewState extends BaseState {
  final navigationService = locate<NavigationService>();
  final userRepo = locate<UserRepository>();
  final foodRepository = locate<FoodRepository>();
  final cartRepo = locate<CartRepository>();

  PageController pageController = PageController();

  OverviewState() {
    ///foodRepository.addMultipleFoods();
    foodRepository.getFoods();
    ///foodRepository.getFavFoods();
    cartRepo.getCart(userRepo.currentUserUID!);
    navigationService.currentIndexNotifier.addListener(_currentIndexListener);
  }

  void animateToPage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _currentIndexListener() {
    animateToPage(navigationService.currentIndexNotifier.value);
  }

  void addToCart(Food food, [bool isAdding = true]) async {
    await cartRepo.addOrRemoveFoodFromCart(userRepo.currentUserUID!, food, isAdding: isAdding);
    if (isAdding) {
      showCustomToast("Added 1qty ${food.title} to cart");
    } else {
      showCustomToast("Removed 1qty ${food.title} from cart");
    }
  }

  void addToFavorite(Food food) {
    userRepo.addFoodToFavorite(userRepo.currentUserUID!, food);
    showCustomToast("Added ${food.title} to favorite");
  }

  void removCartItem(Food food) {
    cartRepo.removeFoodFromCart(userRepo.currentUserUID!, food);
    showCustomToast("Removed ${food.title} from cart");
  }

  Future<void> openCartView(BuildContext context) async {
    await showSnapModelBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      elevation: 10,
      backgroundColor: AppTheme.black.withOpacity(.8),
      topRadius: const Radius.circular(40),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: const CheckoutView(),
      ),
    );
  }
}
