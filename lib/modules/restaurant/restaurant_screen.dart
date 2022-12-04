/*
 * Copyright (c) 2019 Razeware LLC
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, 
 * distribute, sublicense, create a derivative work, and/or sell copies of the 
 * Software in any work that is designed, intended, or marketed for pedagogical or 
 * instructional purposes related to programming, coding, application development, 
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works, 
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:restaurant_finder/models/location.dart';
import 'package:restaurant_finder/modules/favorite/favorite_controller.dart';
import 'package:restaurant_finder/modules/favorite/favorite_screen.dart';
import 'package:restaurant_finder/modules/restaurant/restaurant_controller.dart';
import 'package:restaurant_finder/modules/location/location_screen.dart';
import 'package:restaurant_finder/modules/restaurant/restaurant_tile.dart';
import 'package:get/get.dart';

class RestaurantScreen extends GetView<RestaurantController> {
  final Location location;

  const RestaurantScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Get.to(FavoriteScreen());
            },
          )
        ],
      ),
      body: _buildSearch(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_location),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LocationScreen(
                  isFullScreenDialog: true,
                ),
            fullscreenDialog: true)),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    controller.selectLocation(location);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to eat?'),
            onChanged: (query) => controller.submitQuery(query),
          ),
        ),
        Expanded(
          child: _buildStreamBuilder(),
        )
      ],
    );
  }

  Widget _buildStreamBuilder() {
    return Obx(() {
      // if (controller.restaurantList == null) {
      //   return Center(child: Text('Enter a restaurant name or cuisine type'));
      // }

      if (controller.restaurantList.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildSearchResults();
    });
  }

  Widget _buildSearchResults() {
    return ListView.separated(
      itemCount: controller.restaurantList.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final restaurant = controller.restaurantList[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }
}
