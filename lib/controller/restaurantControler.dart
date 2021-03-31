import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedy_user/model/restaurantModel.dart';

class RestaurantController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  Future<void> createRestaurant(Restaurant restaurant) {
    return _db
        .collection('restaurants')
        .doc(restaurant.name)
        .set(restaurant.toJson());
  }

  // Read
  Stream<List<Restaurant>> viewRestaurants() {
    return _db.collection("restaurants").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Restaurant.fromJson(doc.data())).toList());
  }

  // Delete
  Future<void> deleteRestaurant(Restaurant restaurant) {
    return _db.collection("restaurants").doc(restaurant.name).delete();
  }
}
