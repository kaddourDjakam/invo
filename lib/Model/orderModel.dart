class OrderModel {
  String productName;
  String priceSell;
  String unit;
  String piece;
  String piecesForUnit;
  String nameCategory;
  String availableUnit;

  OrderModel(
      {this.productName,
      this.priceSell,
      this.unit,
      this.piece,
      this.piecesForUnit,
      this.nameCategory,
      this.availableUnit});

  factory OrderModel.fromJson(Map<String, String> json) {
    return OrderModel(
        productName: json["productName"],
        priceSell: json["priceSell"],
        unit: json["unit"],
        piece: json["piece"],
        piecesForUnit: json["piecesForUnit"],
        nameCategory: json["nameCategory"],
        availableUnit: json["availableUnit"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "productName": this.productName,
      "priceSell": this.priceSell,
      "unit": this.unit,
      "piece": this.piece,
      "piecesForUnit": this.piecesForUnit,
      "nameCategory": this.nameCategory,
      "piecesForUnit": this.piecesForUnit,
    };
  }
}
