import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inventory/Model/category.dart';
import 'package:inventory/Model/fullSellModel.dart';
import 'package:inventory/Model/product.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:connectivity/connectivity.dart';

class ServiceAPI implements Exception {
  var _client = http.Client();
  String localHost = "http://192.168.1.102";

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    //var _client = http.Client();
    List<ProductModel> message = [];

    try {
      Uri url = Uri.parse("$localHost/inventory/fetchProducts.php");

      final response = await _client.get(url);
      if (response.statusCode == 200) {
        List<dynamic> userData = await jsonDecode(response.body);
        message = userData
            .map((userData) => ProductModel.fromJson(userData))
            .toList();
        // print(message);

        return message;
      } else {
        return message = [];
      }
    } on SocketException catch (e) {
      // print(e.message);
    } catch (e) {
      print(e.message);
    }
  }

  Future<List<CategoryModel>> fetchAllCategory(BuildContext context) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/fetchAllCategory.php");
      var response = await _client.post(url);

      if (response.statusCode == 200) {
        List<dynamic> userData = jsonDecode(response.body);
        List<CategoryModel> message = userData
            .map((userData) => CategoryModel.fromJson(userData))
            .toList();
        print(message);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> fetchProviders(BuildContext context) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/fetchProviders.php");
      var response = await _client.post(url);

      if (response.statusCode == 200) {
        List<dynamic> userData = jsonDecode(response.body);
        List<ProviderModel> message = userData
            .map((userData) => ProviderModel.fromJson(userData))
            .toList();
        print(userData);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> fetchClients(BuildContext context) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/fetchAllClients.php");

      var response = await _client.post(url);

      if (response.statusCode == 200) {
        List<dynamic> userData = jsonDecode(response.body);
        List<ProviderModel> message = userData
            .map((userData) => ProviderModel.fromJson(userData))
            .toList();
        print(message);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addCategory(BuildContext context, String nameCategory) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/addCategory.php");
      var data = {
        "nameCategory": nameCategory,
      };
      var response = await _client.post(url, body: json.encode(data));

      if (response.statusCode == 200) {
        List message = jsonDecode(response.body);
        print(message[0]);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addProvider(BuildContext context, String name, String phoneNum) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/addProvider.php");

      var data = {
        "name": name,
        "phoneNum": phoneNum,
      };
      var response = await _client.post(url, body: json.encode(data));

      if (response.statusCode == 200) {
        List message = jsonDecode(response.body);
        print(message[0]);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addClient(BuildContext context, String name, String phoneNum) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/addClient.php");
      var data = {
        "name": name,
        "phoneNum": phoneNum,
      };
      var response = await _client.post(url, body: json.encode(data));

      if (response.statusCode == 200) {
        List message = jsonDecode(response.body);
        print(message[0]);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addProduct(
      BuildContext context,
      String productName,
      String pricePerPice,
      String sellPrice,
      String totlaPieces,
      String piecesForUnit,
      String dropDowncartegory,
      String dropDownProviders) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/addProduct.php");

      var data = {
        "productName": productName,
        "pricePerPice": pricePerPice,
        "sellPrice": sellPrice,
        "totlaPieces": totlaPieces,
        "piecesForUnit": piecesForUnit,
        "dropDownValueInch": dropDowncartegory,
        "dropDownProviders": dropDownProviders,
      };
      var response = await _client.post(url, body: json.encode(data));
      if (response.statusCode == 200) {
        List message = jsonDecode(response.body);
        print(message[0]);
        return message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> deleteProduct(
    BuildContext context,
    String idProduct,
  ) async {
    //var _client = http.Client();

    try {
      Uri url = Uri.parse("$localHost/inventory/deleteProduct.php");

      var data = {
        "idProduct": idProduct,
      };
      var response = await _client.post(url, body: json.encode(data));

      if (response.statusCode == 200) {
        List message = jsonDecode(response.body);
        print(message[0]);
        return message[0];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> fetchLastOrderRecord() async {
    try {
      Uri url = Uri.parse("$localHost/inventory/fetchLastOrderRecord.php");

      var response = await _client.post(url);

      if (response.statusCode == 200) {
        List<dynamic> userData = jsonDecode(response.body);

        print(userData[0]['code']);
        return userData;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addNewOrder(
      BuildContext context,
      String productList,
      String totalBillprice,
      String debt,
      String idOrder,
      String clientName) async {
    final f = new DateFormat('yyyy-MM-dd');

    try {
      var data = {
        "productList": '${productList}',
        "totalBillprice": totalBillprice,
        "debt": debt,
        "idOrder": idOrder,
        "OrderDate": '${f.format(DateTime.now())}',
        "clientName": clientName,
      };
      Uri url = Uri.parse("$localHost/inventory/addFullOrder.php");
      var response = await _client.post(url, body: json.encode(data));
      String message = jsonDecode(response.body);
      print(message);
      return message;
    } catch (e) {
      print(e);
    }
  }

  Future fetchTotalDebt(BuildContext context, String clientName) async {
    try {
      var data = {
        "clientName": clientName,
      };

      Uri url = Uri.parse("$localHost/inventory/fetchTotalDebt.php");
      var response = await _client.post(url, body: json.encode(data));
      String userData = jsonDecode(response.body);
      print(userData);
      return userData;
    } catch (e) {
      print(e);
    }
  }
}
