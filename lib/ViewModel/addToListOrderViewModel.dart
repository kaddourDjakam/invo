import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Model/orderModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/productViewModel.dart';
import 'package:provider/provider.dart';
import 'package:inventory/Model/product.dart';

class AddToListOrderViewModel extends ChangeNotifier {
  bool isReady = false;
  bool readyTocloseTap = false;

  TextEditingController units = TextEditingController(text: '0');
  TextEditingController pieces = TextEditingController(text: '0');

  OrderModel orderModelEns;

  ProductModel productModel;

  String totalPieces;
  String totalPrice;

  Future<ProductModel> fetchChosenProduct(
      BuildContext context, ProductViewModel _productViewModel) async {
    productModel = _productViewModel.chosenProduct;

    print(" From the disposed One${productModel}");
    return productModel;
  }

  String validationForInput() {
    if (int.parse(totalPieces) > int.parse(productModel.totalPieces)) {
      isReady = false;
      return "This quantity is not currently available!!";
    } else {
      if (int.parse(totalPieces) > 0) {
        isReady = true;
      } else {
        isReady = false;
      }
      return "";
    }
  }

  String totalPiecesFunc() {
    totalPieces =
        (int.parse(units.text) * (int.parse(productModel.piecesForUnit)) +
                (int.parse(pieces.text)))
            .toString();

    return totalPieces;
  }

  String totalPriceFunc() {
    totalPrice =
        (int.parse(totalPieces) * (double.parse(productModel.priceSell)))
            .toStringAsFixed(2);
    notifyListeners();
    return totalPrice;
  }

  Future<OrderModel> addToOrderList(BuildContext context) async {
    var orderModel = [
      {
        "productName": productModel.productName,
        "priceSell": productModel.priceSell,
        "unit": units.text,
        "piece": pieces.text,
        "piecesForUnit": productModel.piecesForUnit,
        "nameCategory": productModel.nameCategory,
        "availableUnit": productModel.totalPieces
      }
    ];

    List<OrderModel> message = orderModel
        .map((orderModel) => OrderModel.fromJson(orderModel))
        .toList();
    print(orderModel);

    orderModelEns = message[0];
    notifyListeners();

    return orderModelEns;
  }

  closeTap(BuildContext context) async {
    readyTocloseTap = true;

    await Future.delayed(const Duration(seconds: 1));
    readyTocloseTap = true;

    Navigator.pop(context);
  }

  submitOrder(BuildContext context, OrderModel orderModel,
      OrderViewModel orderViewModel) async {
    print(isReady);
    if (isReady == true) {
      orderModel = await addToOrderList(context);

      print("FromTheSubMition ${orderModel.nameCategory}");

      orderViewModel.addToOrder(orderModel);

      closeTap(context);
    }
  }

  textIsemptySelection(TextEditingController controller) {
    if (controller.text.isEmpty) {
      controller.text = '0';

      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  }

  controlerCounter(TextEditingController controller, bool isUp) {
    if (isUp == true) {
      if (int.parse(controller.text) >= 0) {
        controller.text = (int.parse(controller.text) + 1).toString();
      }
    } else {
      if (int.parse(controller.text) > 0) {
        controller.text = (int.parse(controller.text) - 1).toString();
      }
    }
    totalPiecesFunc();
    totalPriceFunc();
  }
}
