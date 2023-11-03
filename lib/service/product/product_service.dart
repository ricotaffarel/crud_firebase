// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductService {
  Future<bool> addProduct(
      String productName, int price, File image, String imageName) async {
    // ignore: duplicate_ignore
    try {
      final FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: dotenv.env['bucket_name'].toString());

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
      final DocumentSnapshot productSnapshot =
          await FirebaseFirestore.instance.collection("products").doc(id).get();

      if (productSnapshot.exists) {
        // Mengambil URL gambar lama dari dokumen Firestore
        final Map<String, dynamic> oldImageURL =
            productSnapshot.data() as Map<String, dynamic>;

        // Memperbarui data dalam Firestore
        await FirebaseFirestore.instance.collection("products").doc(id).update({
          "product_name": productName,
          "price": price,
        });

        if (image != null && imageName != null && image.path.isNotEmpty) {
          final FirebaseStorage storage = FirebaseStorage.instanceFor(
              bucket: dotenv.env['bucket_name'].toString());

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
      //kode awal
      // var data = await FirebaseFirestore.instance
      // .collection("products")
      // .doc(id);

      //kode update
      var data =
          await FirebaseFirestore.instance.collection("products").doc(id);
      final DocumentSnapshot productSnapshot = await data.get();

      //get old image
      final Map<String, dynamic> oldImageURL =
          productSnapshot.data() as Map<String, dynamic>;

      //init storage bucket
      final FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: dotenv.env['bucket_name'].toString());

      //check and delete image
      if (oldImageURL.isNotEmpty) {
        final Reference oldImageRef = storage.refFromURL(oldImageURL["photo"]);
        await oldImageRef.delete();
      }

      await data.delete();

      print("hapus data success");
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
  try {
    var data = await FirebaseFirestore.instance.collection("products").get();
    if (data.docs.isNotEmpty) {
      List<Map<String, dynamic>> newData = data.docs.map((doc) {
        Map<String, dynamic> docData = doc.data();
        docData['document_id'] = doc.id; // Menambahkan Document ID ke data dokumen
        return docData;
      }).toList();
      print("get data success");
      return newData;
    } else {
      print("get data success");
      return [];
    }
  } catch (e) {
    return [];
  }
}

}
