import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Model/product.dart';
import 'package:inventory/View/PicInPicViews/editProductInfo.dart';
import 'package:inventory/View/warning/orderDAtaMayLoss.dart';
import 'package:inventory/ViewModel/editProductViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/productViewModel.dart';
import 'package:inventory/ViewModel/searchViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';

import 'PicInPicViews/HeroAnim.dart';
import 'PicInPicViews/addToOrderListView.dart';
import 'addProduct.dart';

class SearchProductsView extends StatelessWidget {
  SearchViewModel _searchViewModel;
  ProductViewModel _productViewModel;
  EditProductViewModel _editProductInfoViewModel;
  SubmitOrderViewModel _submitOrderViewModel;

  @override
  Widget build(BuildContext context) {
    _editProductInfoViewModel =
        Provider.of<EditProductViewModel>(context, listen: false);
    OrderViewModel _orderListModel =
        Provider.of<OrderViewModel>(context, listen: false);
    _searchViewModel = Provider.of<SearchViewModel>(context, listen: true);
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          child: Material(
            color: Colors.transparent,
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                  child: TextFormField(
                    // keyboardType: textInputType,
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
                      hintText: "Search",
                      hintStyle: TextStyle(color: hintColorStyle),
                      errorMaxLines: 2,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: borderColorStyle),
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
                          child: IconButton(
                            icon: Icon(Icons.close_rounded),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ),
                    //validator: valid,
                    controller: _searchViewModel.searchBar,
                    //validator: signUpViewModelEnst.validateName,
                    onChanged: (__) async {
                      await _searchViewModel
                          .searchForProductsFunc(_productViewModel.products);
                      print(_searchViewModel.searchedProducts);
                    },
                    onSaved: (String val) {
                      _searchViewModel.searchBar.text = val;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                FutureBuilder(
                    future: _searchViewModel
                        .searchForProductsFunc(_productViewModel.products),
                    builder: (Context, snapdata) {
                      if (_searchViewModel.searchedProducts.isNotEmpty) {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ListView.builder(
                                itemCount:
                                    _searchViewModel.searchedProducts.length,
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
                                                  _searchViewModel
                                                      .searchedProducts[index];

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
                                                                  "${_searchViewModel.searchedProducts[index].productName}",
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
                                                                  "${_searchViewModel.searchedProducts[index].nameCategory}",
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
                                                              "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_searchViewModel.searchedProducts[index].priceSell))}",
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
                                                              "${_searchViewModel.searchedProducts[index].totalPieces}",
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
                                                              "${((int.parse(_searchViewModel.searchedProducts[index].totalPieces) / int.parse(_searchViewModel.searchedProducts[index].piecesForUnit)).floor()).toStringAsFixed(0)}",
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
                                              _searchViewModel
                                                      .searchedProducts.length -
                                                  1
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15)
                                          : Container(
                                              child: Text(""),
                                            ),
                                    ],
                                  );
                                }),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.new_releases_outlined,
                                    size: 45,
                                    color: Colors.black45,
                                  ),
                                  Text(
                                    "Sorry , Can not find this products",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
