import 'dart:io';

import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';
import '../controller/product_form_controller.dart';

class ProductFormView extends StatefulWidget {
  String? id;
  String? productName;
  int? price;
  String? imageName;
  bool? isUpdate = false;
  ProductFormView(
      {Key? key,
      this.id,
      this.productName,
      this.price,
      this.imageName,
      this.isUpdate})
      : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Product Name",
                  ),
                  initialValue: productName,
                  onChanged: (value) {
                    controller.productName = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Price",
                  ),
                  initialValue: price == null ? "0" : price.toString(),
                  onChanged: (value) {
                    controller.price = int.tryParse(value) ?? 0;
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // ternari operator kalo gasalah ...[]
              if (isUpdate == true) ...[
                const Text("Gambar awal"),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    imageName.toString(),
                  ),
                ),
              ],
              const SizedBox(
                height: 20.0,
              ),
              if (controller.uploadImage != null)
                Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                  child: Image.file(
                    File(controller.uploadImage!.path),
                    fit: BoxFit.cover,
                  ),
                )
              else
                const Text('Pilih gambar dari galeri'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.pickImage(),
                child: const Text('Pilih Gambar'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            if (isUpdate == true) {
              controller.updateProduct(
                  id!,
                  controller.productName!,
                  controller.price!,
                  File(controller.uploadImage!.path),
                  controller.uploadImage!.name.toString());
            } else {
              controller.addProduct(
                  controller.productName!,
                  controller.price!,
                  File(controller.uploadImage!.path),
                  controller.uploadImage!.name.toString());
            }
          },
          child: const Text("Save"),
        ),
      ),
    );
  }

  @override
  State<ProductFormView> createState() => ProductFormController();
}
