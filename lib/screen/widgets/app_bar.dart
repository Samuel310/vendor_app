import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function onShopNowBtnClicked;
  final Function onMenuBtnClicked;

  CustomAppBar({required this.onMenuBtnClicked, required this.onShopNowBtnClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          RawMaterialButton(
            onPressed: () => onMenuBtnClicked(),
            constraints: BoxConstraints(),
            elevation: 20,
            fillColor: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10, height: 2, color: Colors.grey[600]),
                  SizedBox(height: 5),
                  Container(width: 5, height: 2, color: Colors.grey[600]),
                ],
              ),
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("All Vendors", style: TextStyle(fontSize: 20, color: Colors.grey[700])),
            ),
          ),
          SizedBox(
            height: 40,
            width: 120,
            child: ElevatedButton(
              onPressed: () => onShopNowBtnClicked(),
              style: ElevatedButton.styleFrom(
                elevation: 20,
                primary: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Shop Now", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
