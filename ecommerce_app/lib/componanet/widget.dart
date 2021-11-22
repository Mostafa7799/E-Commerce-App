


import 'package:ecommerce_app/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 mainStyle(){
  return TextStyle(

   fontSize: 25,
   color: Colors.white,
   fontWeight: FontWeight.bold,
  );
}


SnackBar snack(Color color, String msg) {
 return SnackBar(
  backgroundColor: color,
  content: Text('$msg'),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
  ),
 );
}


TextFormField customField({
 TextEditingController? controller,
  String? hint,
  IconData? icon
}){
  return TextFormField(
   controller: controller,
   cursorColor: backGroundColor,
   validator: (value){
    if(value!.isEmpty){
     return 'This Field is required';
    }
   },
   decoration: InputDecoration(
       filled: true,
       fillColor: Colors.white54,
       prefix: Icon(icon,color: backGroundColor,),
       hintText: hint,
       enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
         color: Colors.white,
        ),
       ),
       focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
         color: Colors.white,
        ),
       ),
       errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
         color: Colors.red,
        ),
       ),
       focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
         color: Colors.red,
        ),
       )
   ),
  );
}