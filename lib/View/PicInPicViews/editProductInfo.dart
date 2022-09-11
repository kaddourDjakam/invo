import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/editProductViewModel.dart';
import 'package:provider/provider.dart';

class EditProductInfoView extends StatefulWidget {
  @override
  _EditProductInfoViewState createState() => _EditProductInfoViewState();
}

class _EditProductInfoViewState extends State<EditProductInfoView> {
  EditProductViewModel _editProductViewModel;

  @override
  Widget build(BuildContext context) {
    _editProductViewModel =
        Provider.of<EditProductViewModel>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: true,
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
                Text("Update Product Information",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Expanded(
                    child: Container(
                  width: 200,
                )),
                Container(
                  height: 50,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.upload_rounded),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: _editProductViewModel.fetchProduct(),
              builder: (context, snapdata) {
                if (snapdata.hasData) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: MediaQuery.of(context).size.height * 0.10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _editProductViewModel.product.productName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _editProductViewModel.product.nameCategory,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        textBoxEdi(
                            context,
                            "Price",
                            "DA",
                            _editProductViewModel
                                .getControlerEditTextBox("Price")),
                        textBoxEdi(
                            context,
                            "Units",
                            "Unit",
                            _editProductViewModel
                                .getControlerEditTextBox("Units")),
                        textBoxEdi(
                            context,
                            "Piece",
                            "Piece",
                            _editProductViewModel
                                .getControlerEditTextBox("Piece")),
                        textBoxEdi(
                            context,
                            "Pieces Per Unit",
                            "P/U",
                            _editProductViewModel
                                .getControlerEditTextBox("Pieces Per Unit")),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black45,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.shade300),
                        ),
                      ),
                    ),
                  );
                }
              }),
        ));
  }
}

Widget textBoxEdi(BuildContext context, String title, String type,
    TextEditingController controler) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(left: 15, top: 25),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: new TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: title,
                contentPadding: EdgeInsets.fromLTRB(0.0, 11, 0.0, 10),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.green.shade300,
                    )),
              ),
              cursorColor: Colors.green,
              controller: controler,
              //validator: _addProviderViewModel.validateThePhone,
              onChanged: (__) {},
              onSaved: (String val) {
                //_addProviderViewModel.phoneNum.text = val;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              type,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ],
  );
}
