import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_shop/view/screens/maps/google_map_page.dart';

class LocationWodgets extends StatelessWidget {
  const LocationWodgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        right: 20,
        left: 20,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/2.png",
            width: 30,
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/icons/3.png",
            width: 30,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Location",
                  hintText: "Present Location",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.off(const GoogleMapPage());
              },
              child: const Text("Pick Current Location"))
        ],
      ),
    );
  }
}
