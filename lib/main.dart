import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uber_shop/controllers/auth_controller/category_controller.dart';
import 'package:uber_shop/view/screens/welcome_page/welcome_page.dart';

import 'firebase_options.dart';

//To run this program
//flutter run -d chrome --web-renderer html
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MarketVista",
      home: const WelcomePage(), //SignUpPage(),
      initialBinding: BindingsBuilder(() {
        Get.put<CategoryController>(CategoryController());
      }),
    );
  }
}
