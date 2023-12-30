import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_shop/controllers/auth_controller/category_controller.dart';
import 'package:uber_shop/view/screens/category_page/category_page.dart';

class CategoryTextWidget extends StatelessWidget {
  const CategoryTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final CategoryController _categoryController =
        Get.find<CategoryController>();
    return Obx(() {
      // ignore: avoid_unnecessary_containers
      return Container(
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: GridView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: _categoryController.category.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .12,
                        height: MediaQuery.of(context).size.width * .12,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .18,
                          ),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.network(
                            _categoryController.category[index].categoryImage),
                      ),
                    ),
                    Text(_categoryController.category[index].categoryName)
                  ],
                );
              }),
        ),
      );
    });
  }
}
