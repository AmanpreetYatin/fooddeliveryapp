import 'package:fooddeliveryapp/exports.dart';

class FoodRepository {
  final _firestore = FirebaseFirestore.instance;

  ValueNotifier<List<Food>> foodsNotifier = ValueNotifier<List<Food>>([]);
  ValueNotifier<List<Food>> favFoodsNotifier = ValueNotifier<List<Food>>([]);

  StreamSubscription? streamsSubscriptions;

  Future<Either<ErrorHandler, List<Food>>> getFoods() async {
    try {
      final querySnapshot = _firestore.collection("foods").where("isLive", isEqualTo: true).snapshots();
      print("get food ${querySnapshot.length}");
      streamsSubscriptions?.cancel();
      streamsSubscriptions = null;
      streamsSubscriptions = querySnapshot.listen(
            (snapshot) => _listenToFoodAll(snapshot, false),
      );
      return const Right([]);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, List<Food>>> getFavFoods() async {
    try {
      final querySnapshot = _firestore.collection("foods").where("isFav", isEqualTo: true).snapshots();
      print("get food ${querySnapshot.first}");
      streamsSubscriptions?.cancel();
      streamsSubscriptions = null;
      streamsSubscriptions = querySnapshot.listen(
            (snapshot) => _listenToFoodAll(snapshot, true),
      );
      return const Right([]);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, Food>> getFood(String foodId) async {
    try {
      final food = foodsNotifier.value.firstWhere((food) => food.id == foodId);
      return Right(food);
    } catch (e) {
      try {
        if (foodId.isEmpty) {
          return const Left(ErrorHandler(message: 'No food Id found...'));
        }
        final _productSnapshot = await _firestore.doc(foodId).get();
        if (_productSnapshot.exists) {
          final food = Food.fromMap(_productSnapshot.data() as Map<String, dynamic>);
          foodsNotifier.value.add(food);
          foodsNotifier.notifyListeners();
          return Right(food);
        }
        return const Left(ErrorHandler(message: "Error"));
      } on FirebaseException catch (e) {
        return Left(ErrorHandler(message: e.message ?? ''));
      }
    }
  }

  void _listenToFoodAll(QuerySnapshot snapshot ,  bool isFavFoods) {
    final foods = snapshot.docs.map((doc) {
      return Food.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    if(isFavFoods){
      favFoodsNotifier.value = foods;
      favFoodsNotifier.notifyListeners();
      print("Fav Foods updated: ${foods.length}");
      return;
    }
    foodsNotifier.value = foods;
    foodsNotifier.notifyListeners();

    print("Foods updated: ${foods.length}");
  }

  void _listenToFoods(QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (final document in snapshot.docs) {
      final food = Food.fromMap(document.data());

      final index = foodsNotifier.value.indexWhere((element) => element.id == food.id);
      print("Food Index: $index");
      if (index != -1) {
        foodsNotifier.value.removeAt(index);
        foodsNotifier.value.insert(index, food);
      } else {
        foodsNotifier.value.add(food);
      }

      foodsNotifier.notifyListeners();
    }
  }

  void addMultipleFoods() async {
    final foodsRef = FirebaseFirestore.instance.collection('foods');

    List<Map<String, dynamic>> foodList = [
      {
        "id":"1",
        "title": "Pizza",
        "imagerl":"https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_1280.jpg",
        "description":"Delicious cheese pizza",
        "price": 250,
        "category": "Italian",
        "isLive": true,
        "isFav": false,
        "ingridients": ["Cheese", "Tomato Sauce", "Dough"],
      },
      {
        "id":"2",
        "name": "Burger",
        "imageUrl":"https://cdn.pixabay.com/photo/2019/01/21/12/47/burger-3946012_1280.jpg",
        "description":"Juicy beef burger",
        "price": 120,
        "category": "Fast Food",
        "isLive": true,
        "isFav": false,
        "ingridients": ["Beef Patty", "Lettuce", "Tomato", "Bun"],
      },
      {
        "id":"3",
        "name": "Pasta",
        "imageUrl":"https://cdn.pixabay.com/photo/2016/11/23/18/31/pasta-1854245_1280.jpg",
        "description":"Creamy Alfredo pasta",
        "price": 180,
        "category": "Italian",
        "isLive": true,
        "isFav": false,
        "ingridients": ["Pasta", "Alfredo Sauce", "Parmesan Cheese"],
      },
    ];

    for (var food in foodList) {
      await foodsRef.add(food);  // Creates document with auto ID
    }

    print("Foods added successfully");
  }

}
