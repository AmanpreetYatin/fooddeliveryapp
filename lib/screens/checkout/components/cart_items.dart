import 'package:fooddeliveryapp/exports.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();

    return Expanded(
      child: ListView.builder(
        itemCount: state.cart.length,
        padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
        itemBuilder: (context, index) {
          return CartItemCard(
            cartItem: state.cart[index],
            food: state.cartItems[state.cart[index].foodId],
          );
        },
      ),
    );
  }
}
