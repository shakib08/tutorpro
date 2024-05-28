import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class textinput extends StatelessWidget {
  final String hintText; 
  final TextEditingController? texteditingcontroller; 
  final TextInputType inputType;
  const textinput({required this.hintText, required this.texteditingcontroller, required this.inputType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Container(
      width: size.width*0.8,
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
      ),
      child: TextField(
        controller: texteditingcontroller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: InputBorder.none, 
          hintText: hintText, 
          contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        ),
      ),
    );
  }
}