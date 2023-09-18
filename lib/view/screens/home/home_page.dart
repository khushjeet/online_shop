import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/widgets/banner_widgets.dart';
import 'package:uber_shop/view/screens/widgets/category_text_widget.dart';
import 'package:uber_shop/view/screens/widgets/home_products.dart';
import 'package:uber_shop/view/screens/widgets/locations_widget.dart';
import 'package:uber_shop/view/screens/widgets/men_products_widgets.dart';
import 'package:uber_shop/view/screens/widgets/reuse_text.dart';
import 'package:uber_shop/view/screens/widgets/womens_widgets.dart';

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
          HomeProducts(),
          SizedBox(
            height: 10,
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
          WoMenProductsWidgets(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
