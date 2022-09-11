import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/View/orderView.dart';
import 'package:inventory/View/productView.dart';
import 'package:inventory/View/statisticsView.dart';

class BottomBarViewModel extends ChangeNotifier {
  bool isStockActive = false;
  bool isStatisticsActive = false;
  bool isOrderActive = false;

  void btnStyle(int pressAction) {
    if (pressAction == 1) {
      isStockActive = true;
      isStatisticsActive = false;
      isOrderActive = false;
    } else if (pressAction == 3) {
      isStockActive = false;
      isStatisticsActive = true;
      isOrderActive = false;
    } else if (pressAction == 2) {
      isStockActive = false;
      isStatisticsActive = false;
      isOrderActive = true;
    }
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ProductView()),
        (Route<dynamic> route) => false);
  }

  void navigateToOrder(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => OrderView()),
        (Route<dynamic> route) => false);
  }

  void navigateToStatistics(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => StatisticsView()),
        (Route<dynamic> route) => false);
  }

  void NavigateToPages(BuildContext context, int pressAction) {
    if (pressAction == 1) {
      navigateToProduct(context);
    } else if (pressAction == 2) {
      navigateToOrder(context);
    } else if (pressAction == 3) {
      navigateToStatistics(context);
    }
  }
}
