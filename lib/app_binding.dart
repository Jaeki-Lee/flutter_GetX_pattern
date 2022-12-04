import 'package:get/instance_manager.dart';
import 'package:restaurant_finder/api/zomato_client.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ZomatoClient(), permanent: true);
  }
}
