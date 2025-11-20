import 'package:fooddeliveryapp/exports.dart';



class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<CheckoutState>();
    return AppScaffold(
      backgroundColor: AppTheme.black,
      body: Column(
        children: [
          const SizedBox(height: AppTheme.elementSpacing),
          const NotchBar(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: PageView(
                controller: state.pageController,
                onPageChanged: state.onPageChange,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CartView(),
                  ConfirmOrder(),
                  OrderComplete(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
