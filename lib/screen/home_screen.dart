import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/vendor_model.dart';
import 'package:vendor_app/screen/vendors_screen.dart';

class HomeScreen extends StatelessWidget {
  static final routeNme = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vendors').snapshots(includeMetadataChanges: true),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString(), textAlign: TextAlign.center));
            } else if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documentList = snapshot.data?.docs ?? [];
              List<Vendor> vendorsList = List<Vendor>.from(documentList.map((QueryDocumentSnapshot<Map<String, dynamic>> document) => Vendor.fromJson(document.data(), document.id)));
              return VendorsScreen(vendorsList: vendorsList, key: UniqueKey());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
