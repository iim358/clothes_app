import 'package:appfi/Screens/products/add_product_screen.dart';
import 'package:appfi/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.product});
  ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final result =
        await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    userData = result.data() ?? {};
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Product Detail',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            if (widget.product.uploadedByEmail == userData['email'])
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(
                        product: widget.product,
                        addProduct: false,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                List<ProductModel> products = [];
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  for (var doc in snapshot.data!.data()!['products'] as List) {
                    ProductModel product = ProductModel.fromJson(doc);
                    products.add(product);
                  }
                }
                for (var element in products) {
                  if (element.id == widget.product.id) {
                    widget.product.isAddedToCart = true;
                  }
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        itemCount: widget.product.image!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.product.image![index],
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.product.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.product.price.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.product.description ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            if (widget.product.isAddedToCart != null &&
                widget.product.isAddedToCart!) {
              FirebaseFirestore.instance
                  .collection('cart')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update(
                {
                  'products': FieldValue.arrayRemove(
                    [
                      {
                        'id': widget.product.id,
                        'name': widget.product.name,
                        'price': widget.product.price,
                        'images': widget.product.image,
                        'description': widget.product.description,
                      }
                    ],
                  ),
                },
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from cart'),
                ),
              );
            } else {
              FirebaseFirestore.instance
                  .collection('cart')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .set(
                {
                  'products': FieldValue.arrayUnion(
                    [
                      {
                        'id': widget.product.id,
                        'name': widget.product.name,
                        'price': widget.product.price,
                        'images': widget.product.image,
                        'description': widget.product.description,
                      }
                    ],
                  ),
                },
                SetOptions(merge: true),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to cart'),
                  
                  
                ),
              );
            }
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  widget.product.isAddedToCart != null &&
                          widget.product.isAddedToCart!
                      ? 'Remove from cart'
                      : 'Add to Cart',
                  style: const TextStyle(
                    
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    widget.product.isAddedToCart != null &&
                            widget.product.isAddedToCart!
                        ? Icons.close_rounded
                        : Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}