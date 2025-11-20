import 'package:fooddeliveryapp/exports.dart';


class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, foodDetailPath, arguments: food);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.black.withOpacity(.6),
                        spreadRadius: 20,
                        blurRadius: 20,
                        offset: const Offset(15, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(food.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0 ,
                  top: 0,
                  child: FodaCircleButton(
                    title: "",
                    gradiant: const [
                      AppTheme.orange,
                      AppTheme.orangeDark,
                    ],
                    icon: const Icon(
                      Icons.add,
                      color: AppTheme.white,
                      size: 24,
                    ),
                    onTap: () {
                      state.addToCart(food);
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: FodaCircleButton(
                    title: "",
                    gradiant: const [
                      AppTheme.darkBlue,
                      AppTheme.darkBlue,
                    ],
                    icon: Image.asset(IconPath.favourite),
                    onTap: () {
                      state.addToFavorite(food);
                    },
                  ),
                ),
                Positioned(
                    left: -120,
                    bottom: 100,
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.elementSpacing * 0.5),
                          Text(
                            "\$ ${food.price}",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.red),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
