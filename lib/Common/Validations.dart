import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validations {
  Color erorrColor = Colors.transparent;
  var validation;

  Future<Color> validateInputs(keyForm, context, serviceFunc(context),
      var validation, Color erorrColor) async {
    if (keyForm.currentState.validate()) {
      validation = await serviceFunc(context);
      if (validation[0] == "Exist") {
        print("ExsistFromHEre");
        erorrColor = Colors.red;
        print(erorrColor);
        print(validation);

        return erorrColor;
      } else {
        // print("fuk");
        erorrColor = await Colors.transparent;
        //  Navigator.pop(context);
        return erorrColor;
      }
    } else {
      print("from the validation");
      erorrColor = Colors.red;
      return erorrColor;
    }

    keyForm.currentState.save();
  }

  String validationText(String Val) {
    String pattern = r'^[a-zA-Z]*$';
    RegExp regExp = RegExp(pattern);

    if (Val.length < 3) {
      return 'Please enter a valid word between 3 and 30 character';
    } else if (!regExp.hasMatch(Val)) {
      return 'This field accepts letters only';
    } else
      return null;
  }

  String validationPrice(String Val) {
    String pattern = r'^[1-9]\d{0,7}(?:\.\d{1,4})?$';
    RegExp regExp = RegExp(pattern);

    if (Val.length < 1) {
      return 'Please enter a valid number';
    } else if (!regExp.hasMatch(Val)) {
      return 'This field accepts Numbers only';
    } else
      return null;
  }

  // ^[1-9]\d{0,7}(?:\.\d{1,4})?$

  String validationPhone(String val) {
    String pattern =
        r'(^(?:[+0]9)?[0-9]{10,12}$)'; //var reg=  /^(00213|\+213|0)(5|6|7)[0-9]{8}$/
    RegExp regExp = RegExp(pattern);

    if (val.length < 3) {
      return 'Please enter 8 numbers';
    } else if (!regExp.hasMatch(val)) {
      return "Please enter a valid phone number";
    } else
      return null;
  }
}
