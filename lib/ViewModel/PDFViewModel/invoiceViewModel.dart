import 'package:flutter/cupertino.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Model/orderModel.dart';
import 'package:inventory/Model/pdfModels/invoiceModel.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:provider/provider.dart';

class InvoiceViewModel extends ChangeNotifier {
  Invoice invoice;
  List<InvoiceItem> invoiceListItems = [];

  generateInvoiceObject(BuildContext context, String number) {
    final f = new DateFormat('yyyy-MM-dd');
    ListeningtoDropBox _listeningtoDropBox =
        Provider.of<ListeningtoDropBox>(context, listen: false);
    invoice = Invoice(
      customer: ProviderModel(
        name: _listeningtoDropBox.dropDownValueInchProviders,
        phoneNum: "-----------06",
      ),
      supplier: ProviderModel(
        name: "abdou",
        phoneNum: "0667803632",
      ),
      info: InvoiceInfo(
        date: "${f.format(DateTime.now())}",
        number: number,
      ),
      items: invoiceListItems,
    );
  }
}
