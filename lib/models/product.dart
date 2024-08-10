class Product {
  int? id;
  String name = "";
  String description = "";
  double unitPrice = 0.0;

  Product.withId(this.id, this.name, this.description, this.unitPrice);
  Product(
      {required this.name, required this.description, required this.unitPrice});

  // Convert Product to a Map
  Map<String, Object?> toMap() {
    return <String, Object?>{
      "id": id,
      "name": name,
      "description": description,
      "unitPrice": unitPrice,
    };
  }

  // Create a Product from a Map
  Product.fromObject(dynamic o) {
    this.id = o["id"] != null ? int.tryParse(o["id"].toString()) : null;
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString()) ?? 0.0;
  }
}
