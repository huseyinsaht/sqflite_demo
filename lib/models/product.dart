class Product{
  int? id;
  String name;
  String description;
  double unitPrice;

  Product.withId(this.id, this.name, this.description, this.unitPrice);
  Product({required this.name, required this.description, required this.unitPrice});

  Map<String, Object> toMap(){
    var map = Map<String, Object>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    map["id"] = id!;
    
  }
}