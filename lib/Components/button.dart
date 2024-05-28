import 'package:flutter/material.dart';

class customButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String hintText;
  final Color backgroundColor;


  const customButton({required this.onPressed, required this.hintText, required this.backgroundColor});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor
      ), 
      child: Text(hintText, style: TextStyle(color: Colors.white),)  
    );
  }
}