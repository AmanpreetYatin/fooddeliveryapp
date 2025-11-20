import 'package:fooddeliveryapp/exports.dart';
import 'package:fooddeliveryapp/models/order.dart';

class OrderRepository {
  final ordersCollection = FirebaseFirestore.instance.collection("orders");
  ValueNotifier<List<OrderFood>> ordersNotifier = ValueNotifier<List<OrderFood>>([]);

  Future<Either<ErrorHandler, bool>> createOrder(String uid, OrderFood order) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      Map<String, dynamic> orderMap = order.toMap();
      for (final item in order.orderItems) {
        batch.delete(FirebaseFirestore.instance.collection('users').doc(uid).collection('cart').doc(item.foodId));
      }

      batch.set(ordersCollection.doc(order.orderId), orderMap);
      await batch.commit();

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(ErrorHandler(message: e.message ?? ''));
    }
  }
}
