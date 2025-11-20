import 'package:fooddeliveryapp/exports.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return AppBar(
      leading: Image.asset(IconPath.menu),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        InkWell(
          onTap: () => state.openCartView(context),
          child: Builder(builder: (context) {
            final cartItems = context.select<CheckoutState, List<CartItem>>((v) => v.cart);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.elementSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.black,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Image.asset(IconPath.bag),
                ),
                if (cartItems.isNotEmpty) ...[
                  Positioned(
                    right: -2,
                    child: Text(
                      cartItems.length.toString(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppTheme.red,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
        const SizedBox(width: AppTheme.elementSpacing),
      ],
    );
  }
}
