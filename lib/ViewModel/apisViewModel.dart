import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/fullSellModel.dart';
import 'package:inventory/Model/product.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:inventory/ViewModel/clientsViewModel.dart';
import 'package:inventory/ViewModel/productViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:inventory/services/ApiService.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import 'orderViewModel.dart';

class ApisViewModel extends ChangeNotifier {
  List<ProductModel> products;
  List<ProviderModel> clients;
  ServiceAPI serviceAPI = new ServiceAPI();
  ListeningtoDropBox _listeningtoDropBox;
  SubmitOrderViewModel _submitOrderViewModel;
  String oredeNumber;
  String isOrderSubmited;

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    products = await serviceAPI.fetchAllProducts(context);
    ProductViewModel _productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    _productViewModel.products = products;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }

  Future<List<ProviderModel>> fetchClients(BuildContext context) async {
    clients = await serviceAPI.fetchClients(context);
    ClientViewModel _clientViewModel =
        Provider.of<ClientViewModel>(context, listen: false);
    _clientViewModel.clients = clients;
    notifyListeners();
    return clients;
  }

  fetchLastOrderRecord(BuildContext context) async {
    OrderViewModel _orderListModel =
        Provider.of<OrderViewModel>(context, listen: false);
    List<dynamic> s = await serviceAPI.fetchLastOrderRecord();

    oredeNumber = s[0]['idOrder'];

    _orderListModel.orderNumber = oredeNumber;
    notifyListeners();
    return oredeNumber;
  }

  Future<String> submitOrsder() async {
    return isOrderSubmited;
  }

  addFullOrder(BuildContext context, String prodctList, String totalBillprice,
      String debt) {
    _listeningtoDropBox =
        Provider.of<ListeningtoDropBox>(context, listen: false);

    serviceAPI.addNewOrder(
        context,
        prodctList,
        totalBillprice,
        debt,
        (int.parse(oredeNumber) + 1).toString(),
        _listeningtoDropBox.dropDownValueInchProviders);
  }

  Future<String> fetchTotalDebt(BuildContext context) async {
    _listeningtoDropBox =
        Provider.of<ListeningtoDropBox>(context, listen: false);
    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: false);

    _submitOrderViewModel.totalOldDebts = await serviceAPI.fetchTotalDebt(
        context, _listeningtoDropBox.dropDownValueInchProviders);
    print("object");
    print(await serviceAPI.fetchTotalDebt(
        context, _listeningtoDropBox.dropDownValueInchProviders));

    return _submitOrderViewModel.totalOldDebts;
    ;
  }
}
