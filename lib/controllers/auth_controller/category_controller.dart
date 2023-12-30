import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uber_shop/models/category_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//obs means oserable or reactive
  RxList<CategoryModel> category = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCategory();
  }

  //retrive category from firestore
  void _fetchCategory() {
    _firestore
        .collection("categories")
        //Taking action when it tab
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      category.assignAll(querySnapshot.docs.map(
        (doc) {
          final data = doc.data() as Map<String, dynamic>;
          return CategoryModel(
              categoryImage: data['image'], categoryName: data['categoryName']);
        },
      ).toList());
    });
  }
}
