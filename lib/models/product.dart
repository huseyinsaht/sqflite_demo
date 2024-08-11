class Product {
  int? id;
  var name = "";
  var description = "";
  int? unitPrice;

  Product.withId(this.id, this.name, this.description, this.unitPrice);
  Product({required this.name, required this.description, required this.unitPrice});

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
    id = o["id"] != null ? int.tryParse(o["id"].toString()) : null;
    name = o["name"];
    description = o["description"];
    unitPrice = o["unitPrice"] != null ? int.tryParse(o["unitPrice"].toString()) : null;
  }
}
