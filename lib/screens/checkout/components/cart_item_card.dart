import 'package:fooddeliveryapp/exports.dart';


class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Food? food;
  final bool showDetail;
  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.food,
    this.showDetail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children:[
            Stack(
              children:[
                Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppTheme.red,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(.8),
                      spreadRadius: 5,
                      blurRadius: 15,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(food!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.rectangle,

                ),
              ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.elementSpacing * 0.5),
                    decoration: const BoxDecoration(
                      color: AppTheme.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${cartItem.quantity}",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: FodaCircleButton(
                    title: "",
                    padding: const EdgeInsets.all(6),
                    gradiant: const [
                      AppTheme.darkBlue,
                      AppTheme.darkBlue,
                    ],
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.white,
                      size: 15,
                    ),
                    onTap: () {
                      state.removCartItem(food!);
                    },
                  ),
                ),
         ]
            ),
            if (showDetail) ...[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.elementSpacing * 0.5),
                    Text(
                      "${food?.title}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppTheme.elementSpacing * 0.85),
                    Row(
                      children: [
                        Text(
                          "\$${food!.price * cartItem.quantity}",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppTheme.red,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          " x ${cartItem.quantity}",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppTheme.grey,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.elementSpacing),
                  ],
                ),
              ),
            ]],
        ),
        if (showDetail) ...[
        ],
      ],
    );
  }
}
