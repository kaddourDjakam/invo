import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:inventory/View/PicInPicViews/editProductInfo.dart';
import 'package:inventory/View/searchProductView.dart';
import 'package:inventory/View/warning/orderDAtaMayLoss.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/editProductViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/productViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';

import 'PicInPicViews/HeroAnim.dart';
import 'PicInPicViews/addToOrderListView.dart';
import 'addProduct.dart';
import 'bottomBarView.dart';

class ProductView extends StatelessWidget {
  ProductViewModel _productViewModel;
  ApisViewModel _apisViewModel;
  OrderViewModel _orderListModel;
  SubmitOrderViewModel _submitOrderViewModel;
  EditProductViewModel _editProductInfoViewModel;

  Widget build(BuildContext context) {
    _productViewModel = Provider.of<ProductViewModel>(context, listen: true);

    _apisViewModel = Provider.of<ApisViewModel>(context, listen: false);

    _orderListModel = Provider.of<OrderViewModel>(context, listen: true);

    _editProductInfoViewModel =
        Provider.of<EditProductViewModel>(context, listen: false);

    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: true);

    return ChangeNotifierProvider<ProductViewModel>(
      create: (context) => ProductViewModel(),
      child: Scaffold(
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
                Text("Stock",
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                Expanded(
                    child: Container(
                  width: 200,
                )),
                Container(
                  height: 50,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.search_rounded),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.of(context)
                          .push(HeroDialogRoute(builder: (context) {
                        return SearchProductsView();
                      }));
                    },
                  ),
                ),
                Container(
                  height: 50,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.add_circle_outlined),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AddProduct()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 1 / 100),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  child: SizedBox(height: 20),
                ),
                Container(
                  child: FutureBuilder(
                    future: _apisViewModel.fetchAllProducts(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Consumer<ProductViewModel>(
                            builder: (context, productViewModel, child) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: _productViewModel.products.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Column(
                                    children: [
                                      Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 1,

                                        //Actions

                                        secondaryActions: <Widget>[
                                          Container(
                                            alignment: Alignment.topLeft,
                                            height: 55,
                                            child: IconSlideAction(
                                              caption: "Delete",
                                              icon: Icons.delete,
                                              color: Color(0xffFF6969),
                                              onTap: () {
                                                _productViewModel.dleteProduct(
                                                    context, index);
                                              },
                                            ),
                                          ),
                                        ],
                                        child: Column(children: [
                                          GestureDetector(
                                            onTap: () async {
                                              _editProductInfoViewModel
                                                      .product =
                                                  _productViewModel
                                                      .products[index];

                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                return EditProductInfoView();
                                              }));
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 25,
                                                    right: 10),
                                                height: 55,
                                                //color: Colors.red,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            22 /
                                                            100,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  "${_productViewModel.products[index].productName}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  "${_productViewModel.products[index].nameCategory}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            20 /
                                                            100,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_productViewModel.products[index].priceSell))}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                            Text(
                                                              "DA",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            15 /
                                                            100,
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${_productViewModel.products[index].totalPieces}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                            Text(
                                                              "Piece",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            10 /
                                                            100,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "${((int.parse(_productViewModel.products[index].totalPieces) / int.parse(_productViewModel.products[index].piecesForUnit)).floor()).toStringAsFixed(0)}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                            Text(
                                                              "Box",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        child:
                                                            FloatingActionButton(
                                                          heroTag: null,
                                                          child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.teal
                                                                    .shade800,
                                                            child: CircleAvatar(
                                                              radius: 25,
                                                              backgroundColor:
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.9),
                                                              child: Icon(
                                                                Icons
                                                                    .add_shopping_cart_rounded,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            if (_submitOrderViewModel
                                                                    .isSubmited ==
                                                                false) {
                                                              await _productViewModel
                                                                  .isExistOreder(
                                                                      context,
                                                                      index,
                                                                      _orderListModel
                                                                          .listOfOrders);
                                                              Navigator.of(
                                                                      context)
                                                                  .push(HeroDialogRoute(
                                                                      builder:
                                                                          (context) {
                                                                return AddToOrderListView();
                                                              }));
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(HeroDialogRoute(
                                                                      builder:
                                                                          (context) {
                                                                return OrderDataMayLoss();
                                                              }));
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ]),
                                      ),
                                      index ==
                                              _productViewModel
                                                      .products.length -
                                                  1
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15)
                                          : Container(),
                                    ],
                                  );
                                }),
                          );
                        });
                      } else {
                        return Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3),
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
                    },
                  ),
                ),
              ]),
            )),
        bottomNavigationBar: BottomBarView(),
      ),
    );
  }
}
