
import 'dart:io';
import 'package:appfi/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    super.key,
    this.addProduct = true,
    this.product,
  });

  final bool addProduct;
  final ProductModel? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool _isLoading = false;
  late final TextEditingController _productNameController,
      _productPriceController,
      _productDescriptionController;

  final List<File> _images = [];

  @override
  initState() {
    super.initState();
    _productNameController = TextEditingController();
    _productPriceController = TextEditingController();
    _productDescriptionController = TextEditingController();

    if (!widget.addProduct) {
      _productNameController.text = widget.product!.name ?? '';
      _productPriceController.text = widget.product!.price.toString();
      _productDescriptionController.text = widget.product!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.addProduct ? 'Add Product' : 'Edit Product',
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Name'),
            
                  
                  const SizedBox(height: 10),
                  TextField(
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Product Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Price'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _productPriceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Product Price',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Description'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _productDescriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Product Description',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (widget.addProduct)
              InkWell(
                onTap: () {
                  FilePicker.platform
                      .pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'jpeg'],
                    allowMultiple: true,
                  )
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        _images.addAll(value.files.map((e) => File(e.path!)));
                      });
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Add Images',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_images.isNotEmpty || !widget.addProduct)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 110,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.addProduct
                          ? _images.length
                          : widget.product!.image!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: widget.addProduct
                                      ? Image.file(
                                          _images[index],
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : Image.network(
                                          widget.product!.image![index]
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )),
                              if (widget.addProduct)
                                Positioned(
                                  top: -2,
                                  right: -2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _images.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      margin: const EdgeInsets.all(2),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(
                height: 50,
              ),
            GestureDetector(
              onTap: () async {
                if (_productNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter product name'),
                    ),
                  );
                  return;
                }
                if (_productPriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter product price'),
                    ),
                  );
                  return;
                }
                if (_productDescriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter product description'),
                    ),
                  );
                  return;
                }
                if (_images.isEmpty && widget.addProduct) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please add product images'),
                    ),
                  );
                  return;
                }
                setState(() {
                  _isLoading = true;
                });
                if (widget.addProduct) {
                  List<String> imagesUrl = [];
                  for (var element in _images) {
                    await FirebaseStorage.instance
                        .ref()
                        .child('products')
                        .child(_productNameController.text)
                        .putFile(element)
                        .then((value) async {
                      await value.ref.getDownloadURL().then((value) {
                        imagesUrl.add(value);
                      });
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                    });
                  }

                  final result = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .get();
                  await FirebaseFirestore.instance.collection('products').add({
                    'name': _productNameController.text,
                    'uploaded_by_name': result.data()?['fullName'],
                    'uploaded_by_email': result.data()?['email'],
                    'price': _productPriceController.text,
                    'description': _productDescriptionController.text,
                    'images': imagesUrl,
                    'created_at': DateTime.now().toString(),
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added successfully'),
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  });
                } else {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.product?.id)
                      .set(
                    {
                      'name': _productNameController.text,
                      'uploaded_by_name': widget.product!.uploadedByName,
                      'uploaded_by_email': widget.product!.uploadedByEmail,
                      'price': _productPriceController.text,
                      'description': _productDescriptionController.text,
                      'images': widget.product!.image,
                      'updated_at': DateTime.now().toString(),
                    },
                    SetOptions(merge: true),
                  ).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product updated successfully'),
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !_isLoading
                        ? Text(
                            widget.addProduct
                                ? 'Add Product'
                                : 'Update Product',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          )
                        : const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
