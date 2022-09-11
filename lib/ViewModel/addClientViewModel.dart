import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Common/Validations.dart';
import 'package:inventory/services/ApiService.dart';

class AddClientViewModel extends ChangeNotifier {
  ServiceAPI serviceAPI = new ServiceAPI();
  TextEditingController clientName = new TextEditingController();
  TextEditingController clientPhone = new TextEditingController();
  Color erorrColor = Colors.transparent;
  Validations validateInpu = new Validations();
  final clientKeyForm = GlobalKey<FormState>();
  List validation;

  Future addNewClient(BuildContext context) {
    return serviceAPI.addClient(context, clientName.text, clientPhone.text);
  }

  validationprovider(BuildContext context) async {
    erorrColor = await validateInpu.validateInputs(clientKeyForm, context,
        (context) => addNewClient(context), validation, erorrColor);
    print("fromhre${validateInpu.erorrColor}");
    notifyListeners();

    return erorrColor;
  }

  String validateThetext(String val) {
    return validateInpu.validationText(val);
  }

  String validateThePhone(String val) {
    return validateInpu.validationPhone(val);
  }
}
