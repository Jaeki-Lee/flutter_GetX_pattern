import 'package:get/get.dart';

import 'package:restaurant_finder/modules/main/main_binding.dart';
import 'package:restaurant_finder/modules/main/main_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    // GetPage(
    //   name: Routes.LOCATION,
    //   page: () => LocationScreen(),
    //   binding: LocationBinding(),
    // ),
    // GetPage(
    //     name: Routes.RESTAURANT,
    //     page: () => RestaurantScreen(location: null,),
    //     binding: RestaurantBinding(),
    //     children: [
    //       GetPage(name: Routes.CARDS, page: () => CardsScreen()),
    //     ]),
  ];
}
