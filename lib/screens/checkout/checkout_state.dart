import '../../models/order.dart';
import 'package:fooddeliveryapp/exports.dart';

const int cart = 0;
const int confirm_order = 1;
const int complete_order = 2;
const List<String> paymentMethods = ["Cash", "Credit Card", "Paypal"];

class CheckoutState extends BaseState {
  final foodRepo = locate<FoodRepository>();
  final userRepo = locate<UserRepository>();
  final _cartRepo = locate<CartRepository>();
  final _orderRepo = locate<OrderRepository>();

  Map<String, Food> cartItems = {};
  List<CartItem> cart = [];

  String selectedPaymentMethod = "Cash";
  int currentPage = 0;

  late PageController pageController;
  int totalOrderPrice = 0;

  CheckoutState() {
    pageController = PageController();

    _cartListener();
    _cartRepo.cartNotifier.addListener(_cartListener);
  }

  User get currentUser => userRepo.currentUserNotifier.value!;

  @override
  void dispose() {
    super.dispose();
    _cartRepo.cartNotifier.removeListener(_cartListener);
  }

  int get getTotalAmount {
    int total = 0;
    cartItems.forEach((key, value) {
      try {
        final cartItem = cart.firstWhere((item) => item.foodId == key);
        final newFood = value.copyWith(category: cartItem.category);
        total += cartItem.quantity * newFood.price;
      } catch (_) {}
    });
    return total;
  }

  void _cartListener() async {
    cart = [..._cartRepo.cartNotifier.value];
    notifyListeners();

    _cartRepo.cartNotifier.value.forEach(
      ((CartItem item) async {
        final getFood = await foodRepo.getFood(item.foodId);
        if (getFood.isRight) {
          final product = getFood.right;
          cartItems[item.foodId] = product;
          notifyListeners();
        }
      }),
    );
  }

  void onPageChange(int value) {
    currentPage = value;
    notifyListeners();
  }

  void animateToPage(int page) {
    pageController.jumpToPage(page);
  }

  void setPayment(String value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

  void placeOrder() async {
    if (isLoading == false) {
      setLoading(true);
      final result = await _orderRepo.createOrder(currentUser.uid, initializeOrder());
      setLoading(false);
      if (result.isRight) {
        animateToPage(complete_order);
        showCustomToast("Order Placed, Thank you!");
      } else {
        showCustomToast("Failed to place order");
      }
    }
  }

  OrderFood initializeOrder() {
    totalOrderPrice = getTotalAmount;
    return OrderFood(
      orderId: CodeGenerator.generateCode("order"),
      uid: currentUser.uid,
      imageUrl: cartItems.values.first.imageUrl,
      createdAt: timeNow(),
      updatedAt: timeNow(),
      totalPrice: getTotalAmount,
      status: "placed",
      paymentReference: "",
      deliveryMethods: "home",
      paymentTypes: selectedPaymentMethod,
      shippingDate: timeNow(),
      orderItems: cart
          .map(
            (cartItem) => OrderItem(
              foodId: cartItem.foodId,
              title: cartItems[cartItem.foodId]!.title,
              quantity: cartItem.quantity,
              price: cartItems[cartItem.foodId]!.price,
              createdAt: cartItem.createdAt,
              updatedAt: cartItem.updatedAt,
              coverImageUrl: cartItems[cartItem.foodId]!.title,
              category: cartItems[cartItem.foodId]!.category,
            ),
          )
          .toList(),
    );
  }

  void clearCacheCart() {
    cart.clear();
    cartItems.clear();
    totalOrderPrice = 0;
  }
}
