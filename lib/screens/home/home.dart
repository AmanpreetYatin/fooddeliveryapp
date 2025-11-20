import 'package:fooddeliveryapp/exports.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return AppScaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: ValueListenableBuilder<List<Food>>(
              valueListenable: state.foodRepository.foodsNotifier,
              builder: (context, foods, _) {
                return ListView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  // onPageChanged: (index) {
                  //   setState(() {
                  //     currentPage = index;
                  //   });
                  // },
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    double _scaleFactor = currentPage == index ? 1 : 0.5;
                    Offset offset = currentPage == index ? const Offset(100, 0) : const Offset(220, 400);

                     return FoodCard(food: foods[index]);
                    // return Transform.scale(
                    //   scale: _scaleFactor,
                    //   child: Transform.translate(
                    //     offset: offset,
                    //     child: FoodCard(food: foods[index]),
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
