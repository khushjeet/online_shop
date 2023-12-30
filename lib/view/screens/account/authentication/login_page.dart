import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginWithPhone> {
  TextEditingController countrycode = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  var phone = "";
  @override
  void initState() {
    countrycode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Phone",
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
            const Text(
              "Verificaton",
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
            const Text(
              "we ned to verify your phone number",
              style: TextStyle(fontSize: 15, letterSpacing: 2),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phone = value;
              },
              decoration: InputDecoration(
                  // prefix: Text(
                  //   "$countrycode",
                  //   style: const TextStyle(
                  //       fontSize: 15, fontWeight: FontWeight.bold),
                  // ),
                  hintText: "Enter Mobile Number",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                //   await FirebaseAuth.instance.verifyPhoneNumber(
                //     phoneNumber: countrycode.text + phone,
                //     verificationCompleted: (PhoneAuthCredential credential) {},
                //     verificationFailed: (FirebaseAuthException e) {},
                //     codeSent: (String verificationId, int? resendToken) {},
                //     codeAutoRetrievalTimeout: (String verificationId) {},
                //  );

                await auth.verifyPhoneNumber(
                  // ignore: unnecessary_string_interpolations
                  phoneNumber: '${countrycode.text + phone}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {},
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );

// await auth.verifyPhoneNumber(
//   phoneNumber: '+44 7123 123 456',
//   verificationCompleted: (PhoneAuthCredential credential) async {
//     // ANDROID ONLY!

//     // Sign the user in (or link) with the auto-generated credential
//     await auth.signInWithCredential(credential);
//   },
// );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const OtpPage();
                //     },
                //   ),
                // );
              },
              child: const Text(
                "Send OTP",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
