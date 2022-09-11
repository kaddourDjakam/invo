import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:inventory/ViewModel/addToListOrderViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/productViewModel.dart';
import 'package:provider/provider.dart';

class AddToOrderListView extends StatefulWidget {
  AddToListOrderViewModel addToOrderListViewModel;

  AddToOrderListView({Key key, @required this.addToOrderListViewModel})
      : super(key: key);

  @override
  _AddToOrderListViewState createState() => new _AddToOrderListViewState();
}

class _AddToOrderListViewState extends State<AddToOrderListView> {
  @override
  void initState() {
    super.initState();
  }

  var isInit = true;

  OrderViewModel _orderListModel;
  ProductViewModel _productViewModel;

  Future didChangeDependencies() {
    if (isInit) {
      _orderListModel = Provider.of<OrderViewModel>(context, listen: false);
      _productViewModel = Provider.of<ProductViewModel>(context, listen: true);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.addToOrderListViewModel.pieces = TextEditingController(text: '0');
    widget.addToOrderListViewModel.units = TextEditingController(text: '0');
    widget.addToOrderListViewModel.totalPieces = null;
    widget.addToOrderListViewModel.totalPrice = null;
    widget.addToOrderListViewModel.readyTocloseTap = false;
    widget.addToOrderListViewModel.isReady = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.addToOrderListViewModel =
        Provider.of<AddToListOrderViewModel>(context, listen: true);
    // final categoryKeyForm = GlobalKey<FormState>();
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _productViewModel.isOrderExist == false
              ? Hero(
                  tag: "Order",
                  /* createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },*/
                  child: Material(
                    color: Color(0xffEEEEEE),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Add To Order List",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.black45,
                              thickness: 0.2,
                            ),
                            SizedBox(height: 5),
                            Form(
                              // key: _addProviderViewModel.providerKeyForm,
                              child: FutureBuilder(
                                  future: widget.addToOrderListViewModel
                                      .fetchChosenProduct(
                                          context, _productViewModel),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          Text(
                                            "Boxes quantity",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(Icons
                                                        .exposure_minus_1_rounded),
                                                    onPressed: () {
                                                      widget
                                                          .addToOrderListViewModel
                                                          .controlerCounter(
                                                              widget
                                                                  .addToOrderListViewModel
                                                                  .units,
                                                              false);
                                                    }),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 120,
                                                child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 1,
                                                    showCursor: false,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              12, 7, 12, 7),
                                                      hintText:
                                                          'Enter Units Number',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    32.0)),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                    cursorColor: Colors.green,
                                                    controller: widget
                                                        .addToOrderListViewModel
                                                        .units,
                                                    // validator:
                                                    //    _addProviderViewModel.validateThetext,
                                                    onChanged: (__) {
                                                      widget
                                                          .addToOrderListViewModel
                                                          .textIsemptySelection(
                                                              widget
                                                                  .addToOrderListViewModel
                                                                  .units);
                                                      widget
                                                          .addToOrderListViewModel
                                                          .totalPiecesFunc();
                                                      widget
                                                          .addToOrderListViewModel
                                                          .totalPriceFunc();
                                                    },
                                                    onSaved: (String val) {
                                                      //  _addProviderViewModel.name.text = val;

                                                      val.isEmpty
                                                          ? widget
                                                              .addToOrderListViewModel
                                                              .units
                                                              .text = '0'
                                                          : widget
                                                              .addToOrderListViewModel
                                                              .units
                                                              .text = val;
                                                    }),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(Icons
                                                        .exposure_plus_1_rounded),
                                                    onPressed: () {
                                                      widget
                                                          .addToOrderListViewModel
                                                          .controlerCounter(
                                                              widget
                                                                  .addToOrderListViewModel
                                                                  .units,
                                                              true);
                                                    }),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black45,
                                            thickness: 0.2,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Pieces quantity",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(Icons
                                                        .exposure_minus_1_rounded),
                                                    onPressed: () {
                                                      widget
                                                          .addToOrderListViewModel
                                                          .controlerCounter(
                                                              widget
                                                                  .addToOrderListViewModel
                                                                  .pieces,
                                                              false);
                                                    }),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 120,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 1,
                                                  showCursor: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            12, 7, 12, 7),
                                                    hintText:
                                                        'Enter Pieces Number',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  32.0)),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  cursorColor: Colors.green,
                                                  controller: widget
                                                      .addToOrderListViewModel
                                                      .pieces,
                                                  //validator: _addProviderViewModel.validateThePhone,

                                                  onChanged: (__) {
                                                    widget
                                                        .addToOrderListViewModel
                                                        .textIsemptySelection(widget
                                                            .addToOrderListViewModel
                                                            .pieces);
                                                    widget
                                                        .addToOrderListViewModel
                                                        .totalPiecesFunc();
                                                    widget
                                                        .addToOrderListViewModel
                                                        .totalPriceFunc();
                                                  },
                                                  onSaved: (String val) {
                                                    widget
                                                        .addToOrderListViewModel
                                                        .pieces
                                                        .text = val;
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(Icons
                                                        .exposure_plus_1_rounded),
                                                    onPressed: () {
                                                      widget
                                                          .addToOrderListViewModel
                                                          .controlerCounter(
                                                              widget
                                                                  .addToOrderListViewModel
                                                                  .pieces,
                                                              true);
                                                    }),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black45,
                                            thickness: 0.2,
                                          ),
                                          SizedBox(height: 5),
                                          Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Pieces : ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${widget.addToOrderListViewModel.totalPieces != null ? widget.addToOrderListViewModel.totalPieces : ""}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Price : ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${widget.addToOrderListViewModel.totalPrice == null ? "0.00" : NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(widget.addToOrderListViewModel.totalPrice))} DA",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "${widget.addToOrderListViewModel.totalPieces != null ? widget.addToOrderListViewModel.validationForInput() : ""}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.red.shade300,
                                                    textStyle:
                                                        TextStyle(fontSize: 18),
                                                    shape: StadiumBorder()),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                width: 200,
                                              )),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.green.shade300,
                                                    textStyle:
                                                        TextStyle(fontSize: 18),
                                                    shape: StadiumBorder()),
                                                onPressed: () async {
                                                  widget.addToOrderListViewModel
                                                      .submitOrder(
                                                          context,
                                                          _orderListModel.order,
                                                          _orderListModel);
                                                },
                                                child: widget
                                                            .addToOrderListViewModel
                                                            .readyTocloseTap ==
                                                        false
                                                    ? Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 35,
                                                        width: 60,
                                                        child: Text('Submit'))
                                                    : Container(
                                                        height: 35,
                                                        width: 60,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 5,
                                                                left: 17.5,
                                                                right: 17.5),
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 1.5,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container(
                                          child: Text("Loading..."));
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Hero(
                      tag: "Order",
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 60,
                                color: Colors.orange[300],
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Sorry, this product has already been added to cart",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
    );
  }
}
