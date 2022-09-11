import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/orderModel.dart';
import 'package:inventory/Model/product.dart';
import 'package:inventory/View/PicInPicViews/HeroAnim.dart';
import 'package:inventory/View/PicInPicViews/addToOrderListView.dart';
import 'package:inventory/services/ApiService.dart';
import 'package:provider/provider.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> products;
  ServiceAPI serviceAPI = new ServiceAPI();
  ProductModel chosenProduct;
  bool isOrderExist = false;

  /* Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    products = await serviceAPI.fetchAllProducts(context);
    notifyListeners();
    //print(products[0].name);
    return products;
  }*/

  void dleteProduct(BuildContext context, int index) async {
    await serviceAPI.deleteProduct(context, products[index].idProduct);

    products.remove(index);
    products = products;
    notifyListeners();
  }

  Future fillChosenproduct(int index) async {
    chosenProduct = products[index];
    notifyListeners();
  }

  isExistOreder(
      BuildContext context, int index, List<OrderModel> listOfOrders) async {
    if (listOfOrders != null && listOfOrders.isNotEmpty) {
      for (int i = 0; i < listOfOrders.length; i++) {
        if (products[index].productName == listOfOrders[i].productName) {
          print(listOfOrders[i].productName);
          isOrderExist = true;
          notifyListeners();
        } else {
          isOrderExist = false;
          notifyListeners();
          await fillChosenproduct(index);
        }
      }
    } else {
      isOrderExist = false;
      notifyListeners();

      await fillChosenproduct(index);
    }
  }
}
