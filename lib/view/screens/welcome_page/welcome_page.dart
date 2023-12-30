import 'package:flutter/material.dart';
import 'package:uber_shop/responsive/welcome_home_screen.dart';
import 'package:uber_shop/view/screens/auth/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // ignore: prefer_final_fields
  WelcomeHomeScreenWeb _webwelcome = WelcomeHomeScreenWeb();
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.sizeOf(context).width;
    final heightScreen = MediaQuery.sizeOf(context).height;
    return widthScreen > 800
        ? _webwelcome.webWelcomePage()
        : Scaffold(
            body: Container(
              width: widthScreen,
              height: heightScreen,
              clipBehavior: Clip.hardEdge,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 255, 164, 7)),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    top: -55,
                    left: -145,
                    right: -150,
                    height: heightScreen,
                    child: Image.asset(
                      "assets/welcome.png",
                      width: heightScreen,
                      height: heightScreen,
                    ),
                  ),
                  Positioned(
                      top: heightScreen * .2,
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      )),
                  Positioned(
                      top: heightScreen * .9,
                      bottom: heightScreen * .0005,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Seller",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widthScreen * .25,
                            ),
                            Container(
                              height: heightScreen * 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginPage();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Buyers",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
  }
}
