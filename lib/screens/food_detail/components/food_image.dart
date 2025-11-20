import 'package:fooddeliveryapp/exports.dart';


class DisplayFoodImage extends StatelessWidget {
  const DisplayFoodImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();
    final state = context.watch<FoodDetailState>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius:  BorderRadiusDirectional.all(Radius.circular(20)) ,
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(.6),
                spreadRadius: 20,
                blurRadius: 20,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(state.food.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FodaCircleButton(
            title: "",
            gradiant: const [
              AppTheme.orange,
              AppTheme.orangeDark,
            ],
            icon: const Icon(
              Icons.add,
              color: AppTheme.white,
              size: 22,
            ),
            onTap: () {
              overviewState.addToCart(state.food);
            },
          ),
        ),
        Positioned(
          right: 20,
          top: 0,
          child: FodaCircleButton(
            title: "",
            gradiant: const [
              AppTheme.darkBlue,
              AppTheme.darkBlue,
            ],
            icon: Image.asset(IconPath.favourite),
            onTap: () {
              overviewState.addToFavorite(state.food);
            },
          ),
        ),
      ],
    );
  }
}
