import 'package:fooddeliveryapp/exports.dart';



class FoodDetailView extends StatelessWidget {
  const FoodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        body:  Container(
          child: Column(
            children: [
              const FoodDetailAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      DisplayFoodImage(),
                      SizedBox(height: AppTheme.elementSpacing),
                      CartActions(),
                      SizedBox(height: AppTheme.cardPadding),
                      FoodDetail(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodDetailViewWidget extends StatelessWidget {
  final Food food;
  const FoodDetailViewWidget({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodDetailState(food),
      child: const FoodDetailView(),
    );
  }
}
