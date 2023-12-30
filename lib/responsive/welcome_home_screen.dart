import 'package:flutter/material.dart';

class WelcomeHomeScreenWeb {
  Widget webWelcomePage() {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 80,
          child: Row(
            children: [
              const Text("Logo Image"),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 400,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  color: const Color.fromARGB(96, 161, 158, 158),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Products Brand and Many More"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
