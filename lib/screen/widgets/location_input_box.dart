import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/screen/widgets/input_field.dart';

class CustomLocationInputBox extends StatelessWidget {
  final TextEditingController yourLocationTextController, cartLocationTextController;
  const CustomLocationInputBox({required this.yourLocationTextController, required this.cartLocationTextController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      elevation: 10,
      child: Container(
        height: 122,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 10,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Center(child: Icon(Icons.location_on_outlined, color: Colors.grey[600])),
                    ),
                    Expanded(
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Center(child: Icon(Icons.store, color: Colors.grey[600])),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Location", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    CustomInputField(controller: yourLocationTextController),
                    Text("Cart Location", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    CustomInputField(controller: cartLocationTextController),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
