import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/addCategoryViewModel.dart';
import 'package:inventory/ViewModel/addToListOrderViewModel.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/clientsViewModel.dart';
import 'package:inventory/ViewModel/editProductViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/searchViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';
import 'View/HomeView.dart';
import 'ViewModel/PDFViewModel/invoiceViewModel.dart';
import 'ViewModel/PDFViewModel/pdfInvoiceAPi.dart';
import 'ViewModel/addClientViewModel.dart';
import 'ViewModel/addProductViewModel.dart';
import 'ViewModel/addProviderViewModel.dart';
import 'ViewModel/bottomBarViewModel.dart';
import 'ViewModel/productViewModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomBarViewModel>.value(
              value: BottomBarViewModel(),
            ),
            ChangeNotifierProvider<ProductViewModel>(
                create: (_) => ProductViewModel()),
            ChangeNotifierProvider<AddProductViewMode>(
                create: (_) => AddProductViewMode()),
            ChangeNotifierProvider<ListeningtoDropBox>(
                create: (_) => ListeningtoDropBox()),
            ChangeNotifierProvider<AddCategoryViewModel>(
                create: (_) => AddCategoryViewModel()),
            ChangeNotifierProvider<AddProviderViewModel>(
                create: (_) => AddProviderViewModel()),
            ChangeNotifierProvider<AddToListOrderViewModel>(
                create: (_) => AddToListOrderViewModel()),
            ChangeNotifierProvider<OrderViewModel>(
                create: (_) => OrderViewModel()),
            ChangeNotifierProvider<ApisViewModel>(
                create: (_) => ApisViewModel()),
            ChangeNotifierProvider<ClientViewModel>(
                create: (_) => ClientViewModel()),
            ChangeNotifierProvider<AddClientViewModel>(
                create: (_) => AddClientViewModel()),
            ChangeNotifierProvider<SubmitOrderViewModel>(
                create: (_) => SubmitOrderViewModel()),
            ChangeNotifierProvider<EditProductViewModel>(
                create: (_) => EditProductViewModel()),
            ChangeNotifierProvider<InvoiceViewModel>(
                create: (_) => InvoiceViewModel()),
            ChangeNotifierProvider<PdfInvoiceApi>(
                create: (_) => PdfInvoiceApi()),
            ChangeNotifierProvider<SearchViewModel>(
                create: (_) => SearchViewModel()),
          ],
          child: MaterialApp(
            home: MyHomePage(
              title: "hello MOFO",
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      });
    });
  }
}

class AddToOrderListViewModel {}
