import 'package:flutter/cupertino.dart';
import 'package:inventory/Model/product.dart';

class EditProductViewModel extends ChangeNotifier {
  ProductModel product;
  TextEditingController editUnitController = new TextEditingController();
  TextEditingController editPieceController = new TextEditingController();
  TextEditingController editPriceController = new TextEditingController();
  TextEditingController editPiecesPerUnitController =
      new TextEditingController();

  Future fetchProduct() async {
    await Future.delayed(const Duration(seconds: 1));
    return product;
  }

  getControlerEditTextBox(String title) {
    int units =
        (int.parse(product.totalPieces) / int.parse(product.piecesForUnit))
            .floor();
    int pieces = int.parse(product.totalPieces) -
        (int.parse(product.piecesForUnit) * units);
    int pforU = int.parse(product.piecesForUnit);
    switch (title) {
      case "Price":
        editPriceController.text = product.priceSell;
        return editPriceController;
      case "Units":
        editUnitController.text = units.toStringAsFixed(0);
        return editUnitController;
      case "Piece":
        editPieceController.text = pieces.toString();
        return editPieceController;
      case "Pieces Per Unit":
        editPiecesPerUnitController.text = pforU.toString();
        return editPiecesPerUnitController;

        break;
      default:
    }
  }
}
