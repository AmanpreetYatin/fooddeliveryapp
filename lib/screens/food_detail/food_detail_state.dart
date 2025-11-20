import 'package:fooddeliveryapp/exports.dart';


class FoodDetailState extends BaseState {
  final cartRepo = locate<CartRepository>();
  Food food;
  CartItem? cartItem;

  FoodDetailState(this.food) {
    _listenToCart();
    cartRepo.cartNotifier.addListener(_listenToCart);
  }
  @override
  void dispose() {
    cartRepo.cartNotifier.removeListener(_listenToCart);
    super.dispose();
  }

  _listenToCart() {
    try {
      cartItem = cartRepo.cartNotifier.value.firstWhere((element) => element.foodId == food.id);
    } catch (_) {
      cartItem = null;
    }
    notifyListeners();
  }
}
