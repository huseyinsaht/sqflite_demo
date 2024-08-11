import 'package:flutter/material.dart';

import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductAdd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
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

  Widget buildSaveButton() {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () async {
        await addProduct();
      },
      child: const Text('Add'),
    );
  }


  Future<void> addProduct() async {
      await dbHelper.insert(Product(
      name: txtName.text,
      description: txtDescription.text,
      unitPrice: int.tryParse(txtUnitPrice.text) ?? 0,
    ));
      print("=============== INSERTED ");
    Navigator.pop(context, true);
  }
}