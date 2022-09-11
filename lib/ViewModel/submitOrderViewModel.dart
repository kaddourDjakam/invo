import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/fullSellModel.dart';
import 'package:inventory/Model/orderModel.dart';
import 'package:inventory/Model/pdfModels/invoiceModel.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/services/ApiService.dart';
import 'package:provider/provider.dart';

import 'orderViewModel.dart';

class SubmitOrderViewModel extends ChangeNotifier {
  InvoiceItem item;
  String _totalOldDebts;
  List<Map<String, String>> invoiceListItems = [];
  List<InvoiceItem> harabhah = [];

  String get totalOldDebts {
    return _totalOldDebts;
  }

  set totalOldDebts(String val) {
    _totalOldDebts = val;
  }

  List<OrderModel> fullOrderList;
  bool isSubmited = false;
  bool isPrintOk = false;
  bool isOverpaid = false;
  String json;
  ServiceAPI serviceAPI = new ServiceAPI();
  TextEditingController amountPaid = new TextEditingController();
  String debtsPaid;
  String newDebts;
  String debt;

  calculateThedebts(String totalBill, OrderViewModel _orderListModel) {
    double x = double.parse(amountPaid.text) - double.parse(totalBill);

    if (double.parse(amountPaid.text) > double.parse(totalBill)) {
      isOverpaid = false;
      debt = "0";

      if (x > double.parse(totalOldDebts)) {
        isOverpaid = true;
      } else {
        isOverpaid = false;
        debtsPaid = (x).toString();
        newDebts =
            (double.parse(totalOldDebts) - x + double.parse(debt)).toString();
      }
    } else {
      isOverpaid = false;
      debtsPaid = null;
      debt = null;
      getDebt(_orderListModel);
      if (double.parse(debt) >= 0) {
        isOverpaid = false;
        debtsPaid = null;
        newDebts =
            (double.parse(totalOldDebts) + double.parse(debt)).toString();
      }
    }
    notifyListeners();
  }

  getFullOrder(BuildContext context) async {
    OrderViewModel _orderListModel =
        Provider.of<OrderViewModel>(context, listen: false);
    ApisViewModel _apisViewModel =
        Provider.of<ApisViewModel>(context, listen: false);

    fullOrderList = _orderListModel.listOfOrders;

    json = jsonEncode(fullOrderList.map((i) => i.toJson()).toList()).toString();
    print(json);

    String s = await _apisViewModel.addFullOrder(
        context,
        json,
        _orderListModel.totalPrice(),
        debt == null || debt == "0"
            ? "${(double.parse(debtsPaid) * -1).toString()}"
            : debt);
    loadingAnimation();
    print(s);
    await Future.delayed(const Duration(seconds: 3));
    if (s != "fuckinBillMakesMeMad") {
      isReadyToPrint();
    }
  }

  String getDebt(OrderViewModel _orderListModel) {
    debt = (double.parse(_orderListModel.totalPrice()) -
            double.parse(amountPaid.text))
        .toString();
    notifyListeners();
    return debt;
  }

  bool isReadyToPrint() {
    isPrintOk = true;
    notifyListeners();
    return isPrintOk;
  }

  bool loadingAnimation() {
    isSubmited = true;
    notifyListeners();
    return isSubmited;
  }

  Future invoiceList() async {
    invoiceListItems = [];
    for (int i = 0; i < fullOrderList.length; i++) {
      String qty = (int.parse(fullOrderList[i].piece) +
              (int.parse(fullOrderList[i].unit) *
                  int.parse(fullOrderList[i].piecesForUnit)))
          .toString();
      var totalprice =
          (int.parse(qty) * double.parse(fullOrderList[i].priceSell));

      invoiceListItems.add({
        "productName": fullOrderList[i].productName,
        "priceSell": fullOrderList[i].priceSell,
        "quantity": qty,
        "units": fullOrderList[i].unit,
        "peices": fullOrderList[i].piece,
        "totalunitPrice": totalprice.toStringAsFixed(2),
      });
    }
    harabhah = invoiceListItems
        .map((invoiceListItems) => InvoiceItem.fromJson(invoiceListItems))
        .toList();

    return harabhah;
  }
}
