class ProductModel {
  String? id;
  String? name;
  String? description;
  List<String>? image;
  String? price;
  bool? isFavorite;
  bool? isAddedToCart;
  String? uploadedByEmail;
  String? uploadedByName;
  bool? isDeleted;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.uploadedByEmail,
    this.uploadedByName,
    this.isDeleted = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['images'].cast<String>();
    price = json['price'];
    isFavorite = json['isFavorite'];
    isAddedToCart = json['isAddedToCart'];
    uploadedByEmail = json['uploaded_by_email'];
    uploadedByName = json['uploaded_by_name'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['images'] = image;
    data['price'] = price;
    data['isFavorite'] = isFavorite;
    data['isAddedToCart'] = isAddedToCart;
    data['uploaded_by_email'] = uploadedByEmail;
    data['uploaded_by_name'] = uploadedByName;
    data['isDeleted'] = isDeleted;
    return data;
  }
}