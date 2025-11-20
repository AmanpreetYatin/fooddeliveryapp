import 'package:fooddeliveryapp/exports.dart';



class CartActions extends StatelessWidget {
  const CartActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();
    final state = context.watch<FoodDetailState>();

    if (state.cartItem == null) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing, horizontal: AppTheme.elementSpacing),
          decoration: BoxDecoration(
            color: AppTheme.black,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  overviewState.addToCart(state.food, false);
                },
                child: Icon(
                  Icons.remove,
                  size: 15,
                  color: state.cartItem!.quantity > 1 ? AppTheme.white : null,
                ),
              ),
              const SizedBox(width: AppTheme.elementSpacing),
              Text(
                "${state.cartItem?.quantity}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: AppTheme.elementSpacing),
              InkWell(
                onTap: () {
                  overviewState.addToCart(state.food);
                },
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: AppTheme.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
