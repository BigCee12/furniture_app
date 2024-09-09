class StoreItemModel {
  String name;
  double price;
  String starRating;
  String slashedPrice;
  String imagePath;
  String? description;
  StoreItemModel({
    required this.name,
    required this.price,
    required this.starRating,
    required this.slashedPrice,
    required this.imagePath,
    this.description,
  });
}

final List<StoreItemModel> itemsList = [
  StoreItemModel(
    imagePath: 'assets/store_items/chair1-removebg-preview.png',
    name: "Classic Chair",
    price: 10.4,
    starRating: '4.3',
    slashedPrice: '3.2',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
  StoreItemModel(
    imagePath: 'assets/store_items/chair6-removebg-preview.png',
    name: "Comfert Chair",
    price: 30.4,
    starRating: '4.7',
    slashedPrice: '3.15',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
  StoreItemModel(
    imagePath: 'assets/store_items/chair4-removebg-preview.png',
    name: "High Chair",
    price: 20.2,
    starRating: '4.0',
    slashedPrice: '3.5',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
  StoreItemModel(
    imagePath: 'assets/store_items/chair5-removebg-preview.png',
    name: "Elegant Chair",
    price: 50.4,
    starRating: '3.1',
    slashedPrice: '3.5',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
  StoreItemModel(
    imagePath: 'assets/store_items/chair2-removebg-preview.png',
    name: "Comfortable Chair",
    price: 40.4,
    starRating: '4.7',
    slashedPrice: '2.5',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
  StoreItemModel(
    imagePath: 'assets/store_items/chair4-removebg-preview.png',
    name: "Dinning Chair",
    price: 30.4,
    starRating: '8.4',
    slashedPrice: '3.5',
    description:
        "This is a classic chair that is perfect for your living room. It is made of high-quality materials and is very comfortable to sit on. The chair is available in different colors and is very easy to clean.",
  ),
];
