import 'package:appfi/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesFragmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Favorites',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[Color.fromARGB(255, 83, 106, 118), Color.fromARGB(255, 202, 223, 240)] 
            ),
          ),
          child: SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('wishlist')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: ((context, snapshot) {
                List<ProductModel> products = [];
                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.data()!['products'] as List) {
                    ProductModel product = ProductModel.fromJson(doc);
                    products.add(product);
                  }
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 142, 190, 215),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                products[index].name!,
                              ),
                              Text(
                                products[index].price.toString(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.network(
                            products[index].image![0],
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    );
                  },
                  // itemCount: products.length,
                );
              }),
            ),
          ),
        )));
  }
}
