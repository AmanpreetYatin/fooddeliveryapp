import 'package:fooddeliveryapp/exports.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();
    fodaPrint(state.cartItems);
    return Column(
      children: [
        const SizedBox(height: AppTheme.elementSpacing),
        Text(
          "Your Order",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppTheme.orange),
        ),
        if (state.cart.isEmpty) ...[
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_basket_outlined,
                size: 100,
                color: AppTheme.white,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Text(
                "Cart is Empty",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const Spacer(),
        ] else ...[
          const CartItemList(),
          if (state.cart.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(width: 20,),
                Text(
                  "${state.cart.length} items",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppTheme.grey),
                ),
                Spacer(),
                Text(
                  "\$${state.getTotalAmount}.00",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kToolbarHeight),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
            ),
            child: FodaButton(
              title: 'Confirm Order',
              state: state.isLoading ? ButtonState.loading : ButtonState.idle,
              gradiant: const [AppTheme.orange, AppTheme.red],
              onTap: () {
                state.animateToPage(confirm_order);
              },
            ),
          ),
          const SizedBox(height: kToolbarHeight),
        ],
      ],
    );
  }
}
