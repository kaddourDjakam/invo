import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Common/Validations.dart';
import 'package:inventory/services/ApiService.dart';

class AddProviderViewModel extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  Color erorrColor = Colors.transparent;
  List validation;
  ServiceAPI serviceAPI = new ServiceAPI();
  String validationString;
  Validations validateInpu = new Validations();

  final providerKeyForm = GlobalKey<FormState>();

  validationprovider(BuildContext context) async {
    erorrColor = await validateInpu.validateInputs(providerKeyForm, context,
        (context) => addProvider(context), validation, erorrColor);
    print("fromhre${validateInpu.erorrColor}");
    notifyListeners();
  }

  Future addProvider(BuildContext context) async {
    return serviceAPI.addProvider(context, name.text, phoneNum.text);
  }

  String validateThetext(String val) {
    return validateInpu.validationText(val);
  }

  String validateThePhone(String val) {
    return validateInpu.validationPhone(val);
  }
}
