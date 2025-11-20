import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/exports.dart';

import '../../components/app_scaffold.dart';
import '../../states/overview_state.dart';

class FavoritePage extends StatelessWidget {
   FavoritePage({Key? key}) : super(key: key);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();
    state.foodRepository.getFavFoods();

    return AppScaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: ValueListenableBuilder<List<Food>>(
              valueListenable: state.foodRepository.favFoodsNotifier,
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
