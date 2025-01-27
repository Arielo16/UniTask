class Item {
  final int? id; // Puede ser nulo al crear un nuevo producto
  final String name;
  final double price;

  Item({this.id, required this.name, required this.price});

  // Convertir JSON a objeto Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  // Convertir objeto Item a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
