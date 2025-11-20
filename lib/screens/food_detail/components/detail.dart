import 'package:fooddeliveryapp/exports.dart';


class FoodDetail extends StatelessWidget {
  const FoodDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FoodDetailState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.food.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "\$ ${state.food.price}",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.red,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.cardPadding),
        Text(
          "DETAILS",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppTheme.elementSpacing),
        Text(
          state.food.description,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.grey,
              ),
        ),
        const SizedBox(height: AppTheme.cardPadding),
        Text(
          "INGREDIENT",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          state.food.ingridients.first,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.grey,
          ),
        ),
      ],
    );
  }
}
