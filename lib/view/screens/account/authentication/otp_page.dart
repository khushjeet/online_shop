import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "OTP Sent",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  height: 40,
                  width: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Very OTP",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
