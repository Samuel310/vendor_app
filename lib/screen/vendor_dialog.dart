import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String name;
  final String img;
  final int totalStock;

  const CustomDialogBox({Key? key, required this.name, required this.totalStock, required this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xffD2E1E5),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Icon(Icons.clear)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("4.5", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                              Icon(Icons.star, color: Colors.yellow),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Total Stock",
                            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                          ),
                          Text(
                            widget.totalStock.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[400],
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("VIEW STOCK"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xffD2E1E5),
                          backgroundImage: NetworkImage(this.widget.img),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "1.5 Km away",
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
