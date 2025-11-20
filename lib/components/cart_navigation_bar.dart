import '../exports.dart';


class CartBottomNavigationBar extends StatelessWidget {
  const CartBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();
    final cart = context.select<CheckoutState, List<CartItem>>((v) => v.cart);
    final cartItems = context.select<CheckoutState, Map<String, Food>>((v) => v.cartItems);

    return Container(
      padding: const EdgeInsets.only(
        left: AppTheme.cardPadding,
        right: AppTheme.cardPadding,
        bottom: AppTheme.elementSpacing,
      ),
      height: kBottomNavigationBarHeight * 1.6,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  right: AppTheme.elementSpacing * 0.5,
                  top: AppTheme.elementSpacing * 1.5,
                  bottom: AppTheme.elementSpacing * 1.5,
                ),
                child: FittedBox(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CartItemCard(
                        cartItem: cart[index],
                        food: cartItems[cart[index].foodId],
                        showDetail: false,
                      ),
                      Positioned(
                        right: 0,
                        top: -20,
                        child: Container(
                          padding: const EdgeInsets.all(AppTheme.elementSpacing),
                          decoration: const BoxDecoration(
                            color: AppTheme.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${cart[index].quantity}",
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
          FodaButton(
            title: "Cart",
            gradiant: const [Colors.transparent],
            outline: true,
            onTap: () {
              overviewState.openCartView(context);
            },
          ),
        ],
      ),
    );
  }
}
