import 'package:fooddeliveryapp/exports.dart';


class CartSummery extends StatelessWidget {
  const CartSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Stack(
              clipBehavior: Clip.none,
              children: List.generate(
                state.cart.length,
                (index) => Positioned(
                  left: index.toDouble() * 50,
                  child: SizedBox(
                    height: 65,
                    child: FittedBox(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CartItemCard(
                            cartItem: state.cart[index],
                            food: state.cartItems[state.cart[index].foodId],
                            showDetail: false,
                          ),
                          Positioned(
                            right: 10,
                            top: -25,
                            child: Container(
                              padding: const EdgeInsets.all(AppTheme.elementSpacing),
                              decoration: const BoxDecoration(
                                color: AppTheme.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${state.cart[index].quantity}",
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: AppTheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Total",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.grey,
                  ),
            ),
            Text(
              "\$ ${state.getTotalAmount}.00",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      ],
    );
  }
}
