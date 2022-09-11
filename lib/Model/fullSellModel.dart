class FullSellModel {
  String orderCode;
  String clientId;
  String productName;
  String productQty;
  String productTotalPrice;

  FullSellModel({
    this.orderCode,
    this.clientId,
    this.productName,
    this.productQty,
    this.productTotalPrice,
  });

  factory FullSellModel.fromJson(Map<String, String> json) {
    return FullSellModel(
      orderCode: json["orderCode"],
      clientId: json["clientId"],
      productName: json["productName"],
      productQty: json["productQty"],
      productTotalPrice: json["productTotalPrice"],
    );
  }
}
