// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  Future<bool> addProduct(
      String productName, int price, File image, String imageName) async {
    // ignore: duplicate_ignore
    try {
      final FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://crud-e5f93.appspot.com');

      final Reference storageReference =
          storage.ref().child('product_images/$imageName');

      final UploadTask uploadTask = storageReference.putFile(image);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      final String imageURL = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("products").add(
          {"product_name": productName, "price": price, "photo": imageURL});
      print("add product success");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(String id, String productName, int price,
      File? image, String? imageName) async {
    try {
      final DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection("products")
          .doc(id)
          .get();

      if (productSnapshot.exists) {
        // Mengambil URL gambar lama dari dokumen Firestore
        final Map<String, dynamic> oldImageURL =
            productSnapshot.data() as Map<String, dynamic>;

        // Memperbarui data dalam Firestore
        await FirebaseFirestore.instance
            .collection("products")
            .doc(id)
            .update({
          "product_name": productName,
          "price": price,
        });

        if (image != null && imageName != null && image.path.isNotEmpty) {
          final FirebaseStorage storage = FirebaseStorage.instanceFor(
              bucket: 'gs://crud-e5f93.appspot.com');

          final Reference storageReference =
              storage.ref().child('product_images/$imageName');

          final UploadTask uploadTask = storageReference.putFile(image);

          final TaskSnapshot snapshot =
              await uploadTask.whenComplete(() => null);

          final String imageURL = await snapshot.ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection("products")
              .doc(id)
              .update({"photo": imageURL});

          // Hapus file gambar lama dari Firebase Storage
          print("foto lama");
          print(oldImageURL['photo']);
          if (oldImageURL.isNotEmpty) {
            final Reference oldImageRef =
                storage.refFromURL(oldImageURL["photo"]);
            await oldImageRef.delete();
          }
        }

        print("update product success");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(id)
          .delete();
      print("hapus data success");
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    try {
      var data = await FirebaseFirestore.instance.collection("products").get();
      // List<Map<String, dynamic>> newData =
      //     data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      print("ok");
      List<Map<String, dynamic>> newData = data.docs.map((doc) {
        Map<String, dynamic> docData = doc.data();
        docData['document_id'] =
            doc.id; // Menambahkan Document ID ke data dokumen
        return docData;
      }).toList();
      print(newData[1].toString());
      print("get data success");
      return newData;
    } catch (e) {
      return [];
    }
  }
}
