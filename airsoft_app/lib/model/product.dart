class Product {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  bool? isFavorite;
  bool? isSelected ;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.photo,
    this.isFavorite = false,
    this.isSelected = false
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      photo: json['photo']
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['photo'] = photo;
    return data;
  }

  static List<Product> productList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 24000,
        isSelected: true,
        isFavorite: false,
        photo: 'assets/shooe_tilt_1.png',
        description: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 97',
        price: 22000,
        isFavorite: false,
        photo: 'assets/shoe_tilt_2.png',
        description: "Trending Now"),
  ];
}
