import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/models/product_models.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SizedBox(
          height: 100,
          child: PageView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return ProductModel(productData: productData);

                // Stack(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         height: 90,
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Color(0xffffffff),
                //           ),
                //           boxShadow: const [
                //             BoxShadow(color: Color.fromARGB(239, 250, 249, 249))
                //           ],
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Row(
                //           children: [
                //             Container(
                //               height: 60,
                //               width: 60,
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(10),
                //                 child: Image.network(
                //                   productData['productImages'][0],
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(
                //               width: 10,
                //             ),
                //             Expanded(
                //                 child: Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   productData['productName'],
                //                   style: const TextStyle(
                //                     fontSize: 20,
                //                     letterSpacing: 4,
                //                     color: Color.fromARGB(255, 15, 15, 15),
                //                   ),
                //                   softWrap: false,
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //                 const SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   "\$" +
                //                       " " +
                //                       productData['productPrice']
                //                           .toStringAsFixed(2),
                //                   style: TextStyle(
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.pink),
                //                 ),
                //               ],
                //             ))
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // );
              }),
        );
      },
    );
  }
}
