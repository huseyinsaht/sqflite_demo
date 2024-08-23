import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text= product.name;
    txtDescription.text = product.description ;
    txtUnitPrice.text= product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product detail: ${product.name}"),
        actions: [
          PopupMenuButton<Options>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              const PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
            onSelected: (value) => selectProcess(value),
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Product description"),
      controller: txtDescription,
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Product name"),
      controller: txtName,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Product unitprice"),
      controller: txtUnitPrice,
    );
  }

  void selectProcess(Options value) async {
    switch (value) {
      case Options.delete:
        await dbHelper.delete(product.id as int);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(product.id, txtName.text,
            txtDescription.text, int.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
    }
  }
}
