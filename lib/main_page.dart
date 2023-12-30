import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/account/account_page.dart';
import 'package:uber_shop/view/screens/cart/cart_page.dart';
import 'package:uber_shop/view/screens/category_page/category_page.dart';
import 'package:uber_shop/view/screens/favorites/favorites_page.dart';
import 'package:uber_shop/view/screens/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const FavoritesPage(),
    const AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black,
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/1.png",
                width: 20,
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/2.png",
                  width: 40,
                ),
                label: 'CATEGORIES'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/3.png",
                  width: 20,
                ),
                label: 'CART'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/4.png",
                  width: 20,
                ),
                label: 'FAVORITES'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/5.png",
                  width: 20,
                ),
                label: 'ACCOUNTS'),
          ]),
      body: _pages[pageIndex],
    );
  }
}
