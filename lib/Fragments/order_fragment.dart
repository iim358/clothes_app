import 'package:appfi/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderFragmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Cart',
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
            .collection('cart')
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
                    Image.network(
                      products[index].image![0],
                      width: 80,
                      height: 80,
                    ),
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
                    IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('cart')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'products': FieldValue.arrayRemove([
                            {
                              'id': products[index].id,
                              'name': products[index].name,
                              'price': products[index].price,
                              'images': products[index].image,
                              'description': products[index].description,
                            }
                          ])
                        });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      )),
          )
            )
       );
    
  }
}
