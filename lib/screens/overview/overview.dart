import 'package:fooddeliveryapp/exports.dart';

import '../account/account.dart';
import '../favorite/favorite.dart';
import '../home/home.dart';
import '../search/search.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppTheme.darkBlueLight,
      body: PageView(
        controller: context.read<OverviewState>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          HomePage(),
          FavoritePage(),
          SearchPage(),
          AccountPage(),
        ],
      ),
    );
  }
}
