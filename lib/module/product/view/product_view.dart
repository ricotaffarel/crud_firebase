import 'package:crud_firebase/state_util.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  Widget build(context, ProductController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: const [],
      ),
      body: controller.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: controller.products.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var item = controller.products[index];
                        return Dismissible(
                          key: Key(item[
                              'document_id']), // Gunakan Document ID sebagai key
                          onDismissed: (direction) {
                            // Tambahkan logika ketika di-dismiss (misalnya, hapus item dari daftar)
                            controller.deleteProduct(item['document_id']);
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: NetworkImage(
                                  item["photo"],
                                ),
                              ),
                              title: Text(item["product_name"]),
                              subtitle: Text("${item["price"]}"),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await Get.to(ProductFormView(
                                      id: item["document_id"],
                                      productName: item["product_name"],
                                      price: item["price"],
                                      imageName: item["photo"],
                                      isUpdate: true,
                                    ));
                                    await controller.getProduct();
                                  },
                                  icon: const Icon(Icons.edit)),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: IconButton(
          onPressed: () async {
            await Get.to(ProductFormView(
              // id: "",
              // imageName: '',
              // isUpdate: false,
              // price: 0,
              // productName: "",
            ));
            await controller.getProduct();
          },
          icon: Icon(
            Icons.add_circle,
            size: 50,
            color: Colors.amberAccent.shade700,
          )),
    );
  }

  @override
  State<ProductView> createState() => ProductController();
}
