import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/provider/favorite_provider.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final wishList = ref.watch(favoriteProvider);
    final favoriyteItemProvider = ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        actions: [
          IconButton(
            onPressed: () {
              favoriyteItemProvider.removedAllItems();
            },
            icon: const Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: wishList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: wishList.length,
              itemBuilder: (context, index) {
                final wishData = wishList.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(wishData.imageUrl[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wishData.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.currency_rupee_outlined),
                                    Text(
                                      wishData.price.toStringAsFixed(2),
                                      style: const TextStyle(fontSize: 25),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                favoriyteItemProvider
                                    .removeOneItem(wishData.productId);
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your WisList Is Empty",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "You have  Not add Any Items To You WishList\n You can Add From Home Screen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
