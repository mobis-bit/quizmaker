import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 22),
        children: <TextSpan>[
          TextSpan(
            text: 'Quiz',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          TextSpan(
            text: 'Maker',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
          ),
        ],
      ),
    ),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30.0),
    ),
    width: buttonWidth != null
        ? buttonWidth
        : MediaQuery.of(context).size.width - 48,
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
