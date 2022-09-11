import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Common/Validations.dart';
import 'package:inventory/Model/category.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/View/productView.dart';
import 'package:inventory/services/ApiService.dart';

class AddProductViewMode extends ChangeNotifier {
  TextEditingController productName = TextEditingController();
  TextEditingController buyPrice = TextEditingController();
  TextEditingController sellPrice = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController pieces = TextEditingController();
  var addProduct = GlobalKey<FormState>();
  List<String> validations;
  Color erorrColor = Colors.transparent;
  String totlaPieces;
  String pricePerPice;
  List<CategoryModel> categoryList;
  List<ProviderModel> providers;

  ServiceAPI serviceAPI = new ServiceAPI();
  Validations validateInpu = new Validations();

  Future<List<CategoryModel>> fetchAllCategory(BuildContext context) async {
    categoryList = await serviceAPI.fetchAllCategory(context);
    notifyListeners();
    return categoryList;
  }

  Future<List<ProviderModel>> fetchProviders(BuildContext context) async {
    providers = await serviceAPI.fetchProviders(context);
    notifyListeners();
    return providers;
  }

  Future<String> getTotalPieces(
      TextEditingController pieces, TextEditingController unit) async {
    double a = double.parse(pieces.text) * double.parse(unit.text);
    totlaPieces = await a.toStringAsFixed(0);
    notifyListeners();
    print(totlaPieces);
    return totlaPieces;
  }

  Future<String> getPricePerPiece(
      TextEditingController buyPrice, totlaPieces) async {
    double a = double.parse(buyPrice.text) / double.parse(totlaPieces);
    pricePerPice = await a.toStringAsFixed(3);
    notifyListeners();
    print(pricePerPice);
    return pricePerPice;
  }

  validationProduct(BuildContext context, String a, String b) async {
    erorrColor = await validateInpu.validateInputs(addProduct, context,
        (context) => addProductFunc(context, a, b), validations, erorrColor);
    notifyListeners();
    if (erorrColor == Colors.transparent) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProductView()),
          (Route<dynamic> route) => false);
    }
    print("fromhre${validateInpu.erorrColor}");
    notifyListeners();
  }

  Future addProductFunc(BuildContext context, String dropDownValueInch,
      String dropDownValueInchProviders) async {
    return serviceAPI.addProduct(
        context,
        productName.text,
        pricePerPice,
        sellPrice.text,
        totlaPieces,
        unit.text,
        dropDownValueInch,
        dropDownValueInchProviders);
  }

  String validateThetext(String val) {
    return validateInpu.validationText(val);
  }

  String validateThePrice(String val) {
    return validateInpu.validationPrice(val);
  }

//////////////////////////////////////////////////////////////////////////////////
  ///

}

class ListeningtoDropBox extends ChangeNotifier {
  String dropDownValueInch;
  String text(String val) {
    dropDownValueInch = val;
    notifyListeners();
    return dropDownValueInch;
  }

  String dropDownValueInchProviders;
  String providersText(String val) {
    dropDownValueInchProviders = val;
    notifyListeners();
    return dropDownValueInchProviders;
  }
}
