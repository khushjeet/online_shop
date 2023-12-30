import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/inner_screens/check_out.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPayOnDeliver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Options"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              "Select Payment Methods",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 3,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Pay on Delivery",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                Switch(
                  value: isPayOnDeliver,
                  onChanged: (value) {
                    setState(
                      () {
                        isPayOnDeliver = true;
                      },
                    );
                    if (isPayOnDeliver) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CheckOutPage();
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
