// ignore_for_file: use_build_context_synchronously

import 'package:crud_firebase/service/product/product_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';
import '../view/product_view.dart';

class ProductController extends State<ProductView> {
  static late ProductController instance;
  late ProductView view;
  final ProductService productService = ProductService();
  bool loading = false;

  @override
  void initState() {
    instance = this;
    getProduct();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  List<Map<String, dynamic>> products = [];

  Future<void> getProduct() async {
    loading = true;
    try {
      var data = await productService.getProduct();
      products = [];
      if (data.isNotEmpty) {
        products.addAll(data);
      }
    } catch (e) {
      // Handle error, jika diperlukan
      print(e.toString());
    } finally {
      loading = false;
    }
    setState(() {});
  }

  Future deleteProduct(String id) async {
    var delete = await productService.deleteProduct(id);
    if (delete) {
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('berhasil delete data'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('agal delete data'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
