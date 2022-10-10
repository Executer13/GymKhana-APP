class Product {
  final int id, price;
  final String title, description, image;

  Product({required this.id,required this.price,required this.title,required this.description,required this.image});
}

// list of products
// for our demo
List<Product> products = [
  Product(
    id: 1,
    price: 56,
    title: "Basic",
    image: "images/basic.png",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Product(
    id: 4,
    price: 68,
    title: "Light",
    image: "images/ligtht.png",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Product(
    id: 9,
    price: 39,
    title: "Premium",
    image: "images/premium.png",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
];
