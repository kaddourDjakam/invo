import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/clientsViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'PicInPicViews/HeroAnim.dart';
import 'PicInPicViews/addClientView.dart';
import 'PicInPicViews/submitOrderView.dart';
import 'bottomBarView.dart';

ClientViewModel _clientViewModel;
ApisViewModel _apisViewModel;
ListeningtoDropBox _listeningtoDropBox;
SubmitOrderViewModel _submitOrderViewModel;

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: true);
    _clientViewModel = Provider.of<ClientViewModel>(context, listen: true);
    OrderViewModel _orderListModel =
        Provider.of<OrderViewModel>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      extendBody: true,
      appBar: AppBar(
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Order"),
            Expanded(
                child: Container(
              width: 200,
            )),
            Container(
              height: 50,
              child: _orderListModel.listOfOrders != null
                  ? IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.add_circle_outlined),
                      color: Colors.white,
                      iconSize: 35,
                      onPressed: () async {
                        await _apisViewModel.fetchTotalDebt(context);
                        print(_submitOrderViewModel.totalOldDebts);
                        _listeningtoDropBox.dropDownValueInchProviders != null
                            ? Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  barrierDismissible: true,
                                  pageBuilder: (_, __, ___) =>
                                      SubmitOrderView(),
                                ),
                              )
                            : null;
                      },
                    )
                  : IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.add_circle_outline_outlined),
                      color: Colors.white,
                      iconSize: 35,
                    ),
            ),
          ],
        ),
      ),
      body: _orderListModel.listOfOrders != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: _dropBoxProvider(context),
                    ),
                    Column(
                      children: [
                        Text(
                          "Order Number",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder(
                          future: _apisViewModel.fetchLastOrderRecord(context),
                          builder: (context, snadata) {
                            if (snadata.hasData) {
                              return Container(
                                child: Text(
                                  "${_submitOrderViewModel.isSubmited == true ? (int.parse(_orderListModel.orderNumber)).toString().padLeft(6, '0') : (int.parse(_orderListModel.orderNumber) + 1).toString().padLeft(6, '0')}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            } else {
                              return Container(
                                child: Text("000000"),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _orderListModel.orderListFunc(),
                  builder: (contex, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 25, right: 10),
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "Total price  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_orderListModel.totalPrice()))}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "  DA",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 2),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                              child: Container(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    70 /
                                    100,
                                child: ListView.builder(
                                    itemCount:
                                        _orderListModel.listOfOrders.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 1,

                                        ///left
                                        actions: <Widget>[
                                          Container(
                                            color: Colors.grey[300],
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, left: 18, right: 10),
                                              child: Form(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  textBoxEdit(
                                                      "${_orderListModel.listOfOrders[index].unit}",
                                                      "Boxes",
                                                      _orderListModel,
                                                      index),
                                                  SizedBox(width: 5),
                                                  textBoxEdit(
                                                      "${_orderListModel.totalPieces(index)}",
                                                      "Pieces",
                                                      _orderListModel,
                                                      index),
                                                  SizedBox(width: 5),
                                                  textBoxEdit(
                                                      "${_orderListModel.listOfOrders[index].priceSell}",
                                                      "Price",
                                                      _orderListModel,
                                                      index),
                                                ],
                                              )),
                                            ),
                                          )
                                        ],
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: "Delete",
                                            icon: Icons.delete,
                                            color: Color(0xffFF6969),
                                            onTap: () {
                                              _orderListModel
                                                  .deleteOrder(index);
                                            },
                                          ),
                                        ],

                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          margin: const EdgeInsets.only(
                                              top: 10.0, left: 25, right: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              25 /
                                                              100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${_orderListModel.listOfOrders[index].productName}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "${_orderListModel.listOfOrders[index].nameCategory}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black26,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              15 /
                                                              100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${_orderListModel.listOfOrders[index].unit}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "Unit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              15 /
                                                              100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${_orderListModel.totalPieces(index)}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "Pieces",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              25 /
                                                              100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_orderListModel.totalPriceForOneProduct(index)))}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            "DA",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      );
                                    })),
                          )),
                        ],
                      );
                    } else {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            "There are no orders available at the moment...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black26),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          : Center(
              child: Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  "There are no orders available at the moment...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black26),
                ),
              ),
            ),
      bottomNavigationBar: BottomBarView(),
    );
  }
}

Widget textBoxEdit(
    String hint, String titel, OrderViewModel _orderViewModel, int index) {
  TextEditingController editUnitController = new TextEditingController();
  TextEditingController editPieceController = new TextEditingController();
  TextEditingController editPriceController = new TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          // padding: EdgeInsets.only(left: 12),
          child: Text(
        titel,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      Container(
        width: 100,
        height: 35,
        // padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.fromLTRB(0.0, 11, 0.0, 10),
            border: InputBorder.none,
          ),
          cursorColor: Colors.green,
          controller: titel == "Boxes"
              ? editUnitController
              : titel == "Pieces"
                  ? editPieceController
                  : editPriceController,
          //validator: _addProviderViewModel.validateThePhone,
          onChanged: (__) {
            _orderViewModel.editOrder(index, editUnitController,
                editPieceController, editPriceController);
            _orderViewModel.editOrderValidationInput(index, editUnitController,
                editPieceController, editPriceController);
          },
          onSaved: (String val) {
            //_addProviderViewModel.phoneNum.text = val;
          },
        ),
      ),
    ],
  );
}

Widget _dropBoxProvider(BuildContext context) {
  _apisViewModel = Provider.of<ApisViewModel>(context, listen: false);
  _listeningtoDropBox = Provider.of<ListeningtoDropBox>(context, listen: true);
  return Container(
    margin: const EdgeInsets.only(left: 10.0, right: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "Client ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Column(
          children: [
            _submitOrderViewModel.isSubmited == false
                ? Container(
                    alignment: Alignment.bottomLeft,
                    child: FutureBuilder(
                      future: _apisViewModel.fetchClients(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DropdownMenuItem> menuItemList = _clientViewModel
                              .clients
                              .map((val) => DropdownMenuItem(
                                  value: val.name, child: Text(val.name)))
                              .toList();
                          return DropdownButton(
                            value:
                                _listeningtoDropBox.dropDownValueInchProviders,
                            onChanged: (val) async {
                              print(val);

                              return _listeningtoDropBox.providersText(val);
                            },
                            items: menuItemList,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                : Container(
                    child: Text(
                      "${_listeningtoDropBox.dropDownValueInchProviders}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
            Text(
              "Please Select Client !!",
              style: TextStyle(
                  fontSize: 10,
                  color: _listeningtoDropBox.dropDownValueInchProviders == null
                      ? Colors.red
                      : Colors.transparent),
            ),
          ],
        ),
        SizedBox(width: 10),
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.add_circle),
            color: Colors.black,
            iconSize: 25,
            onPressed: () {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return AddClientView();
              }));
            },
          ),
        ),
      ],
    ),
  );
}
