import '../providerModel.dart';

class Invoice {
  final InvoiceInfo info;
  final ProviderModel supplier;
  final ProviderModel customer;
  final List<InvoiceItem> items;

  const Invoice({
    this.info,
    this.supplier,
    this.customer,
    this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String date;

  const InvoiceInfo({
    this.description,
    this.number,
    this.date,
  });
}

class InvoiceItem {
  String productName;
  String priceSell;
  String quantity;
  String units;
  String peices;
  String totalunitPrice;

  InvoiceItem({
    this.productName,
    this.priceSell,
    this.quantity,
    this.units,
    this.peices,
    this.totalunitPrice,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      productName: json["productName"],
      priceSell: json["priceSell"],
      quantity: json["quantity"],
      units: json["units"],
      peices: json["peices"],
      totalunitPrice: json["totalunitPrice"],
    );
  }
}
