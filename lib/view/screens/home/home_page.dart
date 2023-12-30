import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/widgets/banner_widgets.dart';
import 'package:uber_shop/view/screens/widgets/category_text_widget.dart';
import 'package:uber_shop/view/screens/widgets/locations_widget.dart';
import 'package:uber_shop/view/screens/widgets/men_products_widgets.dart';
import 'package:uber_shop/view/screens/widgets/products_reuses_widgets.dart';
import 'package:uber_shop/view/screens/widgets/reuse_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationWodgets(),
          BannerWidgts(),
          SizedBox(
            height: 10,
          ),
          CategoryTextWidget(),
          SizedBox(
            height: 15,
          ),

          ReUseTxtWedget(
            title: "Men'S Products",
          ),

          SizedBox(
            height: 10,
          ),
          MenProductsWidgets(),
          SizedBox(
            height: 10,
          ),
          // WoMenProductsWidgets(),
          ReUseTxtWedget(
            title: "Laptop'S Products",
          ),
          SizedBox(
            height: 5,
          ),
          //Shoes
          ProductsReusesWidgets(noData: "Laptop", categoryName: 'laptop'),
          SizedBox(
            height: 5,
          ),
          //Shoes
          ProductsReusesWidgets(noData: "Shoes", categoryName: 'shoes'),
          SizedBox(
            height: 5,
          ),
          ProductsReusesWidgets(noData: "Grocery", categoryName: 'Grocery'),
          SizedBox(
            height: 5,
          ),
          ProductsReusesWidgets(noData: "Fasion", categoryName: 'Fasion'),
          SizedBox(
            height: 5,
          ),
          ProductsReusesWidgets(noData: "Women", categoryName: 'women'),
        ],
      ),
    );
  }
}
