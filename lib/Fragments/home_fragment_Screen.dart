import 'package:appfi/Screens/products/add_product_screen.dart';
import 'package:appfi/Screens/products/product_detail_screen.dart';
import 'package:appfi/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeFragmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
     appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[Color.fromARGB(255, 83, 106, 118), Color.fromARGB(255, 202, 223, 240)] 
            )
          ),
      child: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('wishlist')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, wishlist) {
            List<ProductModel> wishlistProduct = [];
            if (wishlist.hasData && wishlist.data!.exists) {
              for (var doc in wishlist.data!.data()!['products'] as List) {
                ProductModel product = ProductModel.fromJson(doc);
                wishlistProduct.add(product);
              }
            }
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('isDeleted', isEqualTo: null)
                  .where('isDeleted', isEqualTo: false)
                  .snapshots(),
              builder: ((context, snapshot) {
                List<ProductModel> products = [];
                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.docs) {
                    ProductModel product = ProductModel.fromJson(doc.data());
                    product.id = doc.id;
                    for (var element in wishlistProduct) {
                      if (kDebugMode) {
                        print(element.id == product.id);
                      }
                      if (element.id == product.id) {
                        product.isFavorite = true;
                      }
                    }
                    products.add(product);
                  }
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                   blurRadius: 10,
                                  offset: Offset.fromDirection(1, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 170,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          products[index].image![0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  products[index].name!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ' ${products[index].price!} SR',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 3, 82, 146),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: GestureDetector(
                              onTap: () {
                                if (products[index].isFavorite == null ||
                                    !products[index].isFavorite!) {
                                  FirebaseFirestore.instance
                                      .collection('wishlist')
                                      .doc(
                                        FirebaseAuth.instance.currentUser!.uid,
                                      )
                                      .set(
                                    {
                                      'products': FieldValue.arrayUnion(
                                        [
                                          {
                                            'id': products[index].id,
                                            'name': products[index].name,
                                            'price': products[index].price,
                                            'images': products[index].image,
                                            'description':
                                                products[index].description,
                                          }
                                        ],
                                      ),
                                    },
                                    SetOptions(merge: true),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to wishlist'),
                                    ),
                                  );
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('wishlist')
                                      .doc(
                                        FirebaseAuth.instance.currentUser!.uid,
                                      )
                                      .set(
                                    {
                                      'products': FieldValue.arrayRemove(
                                        [
                                          {
                                            'id': products[index].id,
                                            'name': products[index].name,
                                            'price': products[index].price,
                                            'images': products[index].image,
                                            'description':
                                                products[index].description,
                                          }
                                        ],
                                      ),
                                    },
                                    SetOptions(merge: true),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Removed from wishlist'),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2,
                                      offset: Offset.fromDirection(1, 1),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  products[index].isFavorite != null &&
                                          products[index].isFavorite!
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            );
          },
        ),
      ),
        )
        )
    );
  }
}