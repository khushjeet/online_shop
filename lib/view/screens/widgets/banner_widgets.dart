import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidgts extends StatefulWidget {
  const BannerWidgts({super.key});

  @override
  State<BannerWidgts> createState() => _BannerWidgtsState();
}

class _BannerWidgtsState extends State<BannerWidgts> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerList = [];

  getBanners() async {
    return await _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _bannerList.add(doc['image']);
        });
      }
    });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _bannerList.map((
          e,
        ) {
          return Builder(builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Image.network(
                e,
                scale: 5,
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          //onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ));
  }
}
