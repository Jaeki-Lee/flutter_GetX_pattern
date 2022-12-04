import 'package:get/get.dart';
import 'package:restaurant_finder/modules/favorite/favorite_controller.dart';
import 'package:restaurant_finder/modules/location/location_query_controller.dart';
import 'package:restaurant_finder/modules/restaurant/restaurant_controller.dart';
import 'location_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
    Get.put(LocationQueryController(client: Get.find()));
    Get.put(RestaurantController(client: Get.find()));
    Get.put(FavoriteController());
  }
}
