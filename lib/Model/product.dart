class ProductModel {
  String idProduct;
  String productName;
  String nameCategory;
  String pricePerPice;
  String priceSell;
  String piecesForUnit;
  String totalPieces;
  String name;

  ProductModel({
    this.idProduct,
    this.productName,
    this.nameCategory,
    this.pricePerPice,
    this.priceSell,
    this.name,
    this.piecesForUnit,
    this.totalPieces,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        idProduct: json["idProduct"],
        productName: json["productName"],
        nameCategory: json["nameCategory"],
        pricePerPice: json["pricePerPice"],
        priceSell: json["sellPrice"],
        name: json["name"],
        piecesForUnit: json["piecesForUnit"],
        totalPieces: json["totalPieces"]);
  }
}
