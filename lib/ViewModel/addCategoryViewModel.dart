import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Common/Validations.dart';
import 'package:inventory/services/ApiService.dart';
import 'package:provider/provider.dart';

class AddCategoryViewModel extends ChangeNotifier {
  TextEditingController nameCategory = TextEditingController();
  Color erorrColor = Colors.transparent;
  var validation;
  ServiceAPI serviceAPI = new ServiceAPI();
  final categoryKeyForm = GlobalKey<FormState>();
  String validationString;
  Validations validateInpu = new Validations();

  validationCategory(BuildContext context) async {
    erorrColor = await validateInpu.validateInputs(categoryKeyForm, context,
        (context) => addCategory(context), validation, erorrColor);
    notifyListeners();
    if (erorrColor == Colors.transparent) {
      Navigator.pop(context);
    }
    print("fromhre${validateInpu.erorrColor}");
    notifyListeners();
  }

  Future addCategory(BuildContext context) async {
    return serviceAPI.addCategory(context, nameCategory.text);
  }

  String validateThetext(String val) {
    validationString = validateInpu.validationText(val);
    notifyListeners();
    return validationString;
  }
}
