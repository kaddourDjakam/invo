import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/product.dart';

class SearchViewModel extends ChangeNotifier {
  List<ProductModel> _searchedProducts = [];
  TextEditingController searchBar = new TextEditingController();

  List<ProductModel> get searchedProducts {
    return _searchedProducts;
  }

  set searchedProducts(List<ProductModel> x) {
    _searchedProducts = x
      ..sort((a, b) => b.productName.compareTo(a.productName));

    notifyListeners();
  }

  Future<List<ProductModel>> searchForProductsFunc(
      List<ProductModel> allProducts) async {
    searchedProducts = await allProducts.where((product) {
      return product.productName
          .toLowerCase()
          .contains(searchBar.text.toLowerCase());
    }).toList();

    return searchedProducts;
  }
}
