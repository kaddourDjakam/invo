import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/View/productView.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:provider/provider.dart';

import 'PicInPicViews/AddNewCategory.dart';
import 'PicInPicViews/HeroAnim.dart';
import 'PicInPicViews/AddNewProviderView.dart';

Color hintColorStyle = Color(0xff160025).withOpacity(0.3);
Color borderColorStyle = Color(0xff00F185);
AddProductViewMode _addProductViewMode;
ListeningtoDropBox _listeningtoCategoryDrop;

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _addProductViewMode =
        Provider.of<AddProductViewMode>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal,
                  Colors.teal.shade900,
                ]),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.close_rounded),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProductView()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
              Expanded(
                  child: Container(
                width: 200,
              )),
              Text("Add New Product",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              Expanded(
                  child: Container(
                width: 200,
              )),
              Container(
                height: 40,
                width: 40,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.check_outlined),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    if (_listeningtoCategoryDrop.dropDownValueInch == null ||
                        _listeningtoCategoryDrop.dropDownValueInchProviders ==
                            null) {
                    } else {
                      /* _addProductViewMode.validationProduct(
                          context,
                          _listeningtoCategoryDrop.dropDownValueInch,
                          _listeningtoCategoryDrop.dropDownValueInchProviders);*/
                      _addProductViewMode.validationProduct(
                          context,
                          _listeningtoCategoryDrop.dropDownValueInch,
                          _listeningtoCategoryDrop.dropDownValueInchProviders);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _addProductViewMode.addProduct,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  textBox(
                      "Product Name",
                      TextInputType.text,
                      _addProductViewMode.productName,
                      "",
                      _addProductViewMode.validateThetext),
                  SizedBox(height: 10),
                  textBox(
                      "Total buy price",
                      TextInputType.number,
                      _addProductViewMode.buyPrice,
                      "DA",
                      _addProductViewMode.validateThePrice),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: textBox(
                            "Boxes",
                            TextInputType.number,
                            _addProductViewMode.unit,
                            "Box",
                            _addProductViewMode.validateThePrice),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: textBox(
                            "Pices",
                            TextInputType.number,
                            _addProductViewMode.pieces,
                            "Piece",
                            _addProductViewMode.validateThePrice),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  textBox(
                      "Sell Price",
                      TextInputType.number,
                      _addProductViewMode.sellPrice,
                      "DA",
                      _addProductViewMode.validateThePrice),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total pieces:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        FutureBuilder(
                            future: _addProductViewMode.getTotalPieces(
                                _addProductViewMode.pieces,
                                _addProductViewMode.unit),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${_addProductViewMode.totlaPieces}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Piece",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    Container(
                                      child: Text("0.0"),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Piece",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Price per piece ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        FutureBuilder(
                            future: _addProductViewMode.getPricePerPiece(
                                _addProductViewMode.buyPrice,
                                _addProductViewMode.totlaPieces),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${_addProductViewMode.pricePerPice}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "DA",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    Container(
                                      child: Text("0.0"),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "DA",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _dropBoxCategory(context),
                  SizedBox(height: 20),
                  _dropBoxProvider(context),
                ]),
              ),
            ))
      ]),
    );
  }
}

Widget _dropBoxCategory(BuildContext context) {
  _addProductViewMode = Provider.of<AddProductViewMode>(context, listen: false);
  _listeningtoCategoryDrop =
      Provider.of<ListeningtoDropBox>(context, listen: true);
  return Container(
    margin: const EdgeInsets.only(left: 40.0, right: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Container(
          width: 200,
        )),
        Container(
          alignment: Alignment.centerRight,
          child: FutureBuilder(
            future: _addProductViewMode.fetchAllCategory(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DropdownMenuItem> menuItemList = _addProductViewMode
                    .categoryList
                    .map((val) => DropdownMenuItem(
                        value: val.nameCategory, child: Text(val.nameCategory)))
                    .toList();
                return DropdownButton(
                  value: _listeningtoCategoryDrop.dropDownValueInch,
                  onChanged: (val) async {
                    print(val);

                    return _listeningtoCategoryDrop.text(val);
                  },
                  items: menuItemList,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.add_circle),
            color: Colors.black,
            iconSize: 35,
            onPressed: () {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return AddNewCategoryView();
              }));
            },
          ),
        ),
      ],
    ),
  );
}

Widget _dropBoxProvider(BuildContext context) {
  _addProductViewMode = Provider.of<AddProductViewMode>(context, listen: false);
  _listeningtoCategoryDrop =
      Provider.of<ListeningtoDropBox>(context, listen: true);

  _listeningtoCategoryDrop.providersText(null);

  return Container(
    margin: const EdgeInsets.only(left: 40.0, right: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "Provider",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Container(
          width: 200,
        )),
        Container(
          alignment: Alignment.centerRight,
          child: FutureBuilder<List<ProviderModel>>(
            future: _addProductViewMode.fetchProviders(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DropdownMenuItem> menuItemList = _addProductViewMode
                    .providers
                    .map((val) => DropdownMenuItem(
                        value: val.name, child: Text(val.name)))
                    .toList();
                return DropdownButton(
                  value: _listeningtoCategoryDrop.dropDownValueInchProviders,
                  onChanged: (val) async {
                    print(val);

                    return _listeningtoCategoryDrop.providersText(val);
                  },
                  items: menuItemList,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.add_circle),
            color: Colors.black,
            iconSize: 35,
            onPressed: () {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return AddNewProviderView();
              }));
            },
          ),
        ),
      ],
    ),
  );
}

Widget textBox(String hint, TextInputType textInputType,
    TextEditingController controlerText, String type, var valid) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20.0, right: 20),
          child: TextFormField(
            keyboardType: textInputType,
            cursorColor: Colors.green,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.7,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            autofocus: false,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: hintColorStyle),
              errorMaxLines: 2,
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: borderColorStyle),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              filled: true,
              fillColor: Colors.white,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.7)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.7)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 25,
                alignment: Alignment.center,
                child: Text(
                  type,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            validator: valid,
            controller: controlerText,
            //validator: signUpViewModelEnst.validateName,
            onChanged: (hint) {
              if (hint == "Unit" || hint == "Pices") {
                _addProductViewMode.getTotalPieces(
                    _addProductViewMode.pieces, _addProductViewMode.unit);
                print(_addProductViewMode.totlaPieces);
              } else if (hint == "Buy Price") {
                _addProductViewMode.getPricePerPiece(
                    _addProductViewMode.buyPrice,
                    _addProductViewMode.totlaPieces);
              }
            },
            onSaved: (String val) {
              // signUpViewModelEnst.firstName.text = val;
            },
          ),
        )
      ]);
}
