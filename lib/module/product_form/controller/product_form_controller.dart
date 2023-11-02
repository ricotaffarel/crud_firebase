import 'dart:io';

import 'package:crud_firebase/service/product/product_service.dart';
import 'package:crud_firebase/state_util.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';
import 'package:image_picker/image_picker.dart';
import '../view/product_form_view.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;
  String? productName;
  int? price;
  XFile? uploadImage;

  @override
  void initState() {
    instance = this;
    super.initState();
    productName = widget.productName;
    price = widget.price ?? 0;
  }

  @override
  void dispose() => super.dispose();

  Future addProduct(
      String productName, int price, File image, String imageName) async {
    ProductService().addProduct(productName, price, image, imageName);
    Get.back();
  }

  Future updateProduct(String id, String productName, int price, File image,
      String imageName) async {
    ProductService().updateProduct(id, productName, price, image, imageName);
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        uploadImage =
            XFile(pickedFile.path); // Menggunakan XFile untuk menyimpan gambar
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
