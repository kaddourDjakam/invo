import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/fullSellModel.dart';
import 'package:inventory/Model/orderModel.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';

class OrderViewModel extends ChangeNotifier {
  OrderModel order;
  List<OrderModel> listOfOrders;
  String orderNumber;

  var ord;
  List<Map<String, String>> orderList = [];

  List<OrderModel> message;

  Future<List<OrderModel>> addToOrder(OrderModel newOrder) async {
    order = newOrder;
    notifyListeners();
    orderList.add({
      "productName": order.productName,
      "priceSell": order.priceSell,
      "unit": order.unit,
      "piece": order.piece,
      "piecesForUnit": order.piecesForUnit,
      "nameCategory": order.nameCategory,
      "availableUnit": order.availableUnit
    });
    notifyListeners();
    List<OrderModel> message =
        orderList.map((orderList) => OrderModel.fromJson(orderList)).toList();
    notifyListeners();
    listOfOrders = message;
    notifyListeners();
    return listOfOrders;
  }

  addToList() {
    return ord = [
      {
        "productName": order.productName,
        "priceSell": order.priceSell,
        "unit": order.unit,
        "piece": order.piece,
        "piecesForUnit": order.piecesForUnit,
        "nameCategory": order.nameCategory,
        "availableUnit": order.availableUnit
      }
    ];
  }

  String totalPrice() {
    double a = 0;
    for (int i = 0; i < listOfOrders.length; i++) {
      a = a +
          (int.parse(listOfOrders[i].piece) +
                  int.parse(listOfOrders[i].unit) *
                      int.parse(listOfOrders[i].piecesForUnit)) *
              double.parse(listOfOrders[i].priceSell);
    }
    return a.toStringAsFixed(2);
  }

  String totalPieces(int index) {
    return (int.parse(listOfOrders[index].piece) +
            (int.parse(listOfOrders[index].unit) *
                int.parse(listOfOrders[index].piecesForUnit)))
        .toString();
  }

  String totalPriceForOneProduct(int index) {
    return (int.parse(totalPieces(index)) *
            double.parse(listOfOrders[index].priceSell))
        .toStringAsFixed(2);
  }

  Future orderListFunc() async {
    return orderList;
  }

  deleteOrder(int index) {
    orderList.removeAt(index);
    listOfOrders.removeAt(index);
    notifyListeners();
  }

  editOrderValidationInput(
      int index,
      TextEditingController unitController,
      TextEditingController pieceController,
      TextEditingController priceController) {
    if (int.parse(totalPieces(index)) >
        int.parse(listOfOrders[index].availableUnit)) {
      print(listOfOrders[index].availableUnit);
      int restPieces = int.parse(listOfOrders[index].availableUnit) %
          int.parse(listOfOrders[index].piecesForUnit);
      String restUnit = (int.parse(listOfOrders[index].availableUnit) /
              int.parse(listOfOrders[index].piecesForUnit))
          .toStringAsFixed(0);

      listOfOrders[index].piece = restPieces.toString();
      listOfOrders[index].unit = restUnit;
      notifyListeners();
      print(listOfOrders[index].piece);
      print(listOfOrders[index].unit);
    }
  }

  editOrder(
      int index,
      TextEditingController unitController,
      TextEditingController pieceController,
      TextEditingController priceController) {
    if (unitController.text != null && unitController.text != "") {
      listOfOrders[index].unit = unitController.text;
    }
    if (pieceController.text != null && pieceController.text != "") {
      int rest = int.parse(pieceController.text) %
          int.parse(listOfOrders[index].piecesForUnit);

      listOfOrders[index].piece = rest.toString();
    }
    if (priceController.text != null && priceController.text != "") {
      listOfOrders[index].priceSell = priceController.text;
    }
  }

  /**************************************************** */

}
