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
import 'package:get/get.dart';
import 'package:restaurant_finder/modules/main/location_controller.dart';
import 'package:restaurant_finder/modules/location/location_query_controller.dart';

class LocationScreen extends GetView<LocationQueryController> {
  final bool isFullScreenDialog;

  const LocationScreen({Key? key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Where do you want to eat?')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter a location'),
              onChanged: (query) => controller.submitQuery(query),
            ),
          ),
          Expanded(
            child: _buildResults(),
          )
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Obx(() {
      final locationList = controller.locationList;

      if (locationList.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildSearchResults();
    });
  }

  Widget _buildSearchResults() {
    // 2
    return ListView.separated(
      itemCount: controller.locationList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = controller.locationList[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            LocationController locationController = Get.find();
            locationController.selectLocation(location);

            Get.back();

            // if (isFullScreenDialog) {
            //   Get.back();
            // }
          },
        );
      },
    );
  }
}
