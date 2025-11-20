import 'package:fooddeliveryapp/exports.dart';


class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PAYMENT METHOD",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Click one of your card.",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.grey,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: AppTheme.cardPadding),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: List.generate(
            paymentMethods.length,
            (index) => Row(
              children: [
                Radio<bool>(
                  value: state.selectedPaymentMethod == paymentMethods[index],
                  groupValue: true,
                  onChanged: (v) {
                    state.setPayment(paymentMethods[index]);
                  },
                ),
                Text(
                  paymentMethods[index],
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
