import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Model/orderModel.dart';

import 'package:inventory/View/orderView.dart';
import 'package:inventory/ViewModel/PDFViewModel/invoiceViewModel.dart';
import 'package:inventory/ViewModel/PDFViewModel/pdfInvoiceAPi.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:inventory/ViewModel/addProviderViewModel.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';

class SubmitOrderView extends StatefulWidget {
  @override
  _SubmitOrderViewState createState() => _SubmitOrderViewState();
}

ListeningtoDropBox _listeningtoDropBox;
OrderViewModel _orderListModel;
SubmitOrderViewModel _submitOrderViewModel;
PdfInvoiceApi _pdfInvoiceApi;
InvoiceViewModel _invoiceViewModel;
ApisViewModel _apisViewModel;

class _SubmitOrderViewState extends State<SubmitOrderView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listeningtoDropBox =
        Provider.of<ListeningtoDropBox>(context, listen: true);
    _pdfInvoiceApi = Provider.of<PdfInvoiceApi>(context, listen: true);

    _orderListModel = Provider.of<OrderViewModel>(context, listen: false);

    _invoiceViewModel = Provider.of<InvoiceViewModel>(context, listen: true);
    _apisViewModel = Provider.of<ApisViewModel>(context, listen: false);

    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "submit1",
          /* createRectTween: (begin, end) {
                return CustomRectTween(begin: begin, end: end);
              },*/
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _submitOrderViewModel.isPrintOk == false
                          ? "Payment"
                          : "Printing",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _submitOrderViewModel.isPrintOk == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "The amount paid",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black54),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "0000000 DA",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0.0, 11, 0.0, 10),
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.green,
                                    controller:
                                        _submitOrderViewModel.amountPaid,
                                    //validator: _addProviderViewModel.validateThePhone,
                                    onChanged: (__) {
                                      _submitOrderViewModel.calculateThedebts(
                                          _orderListModel.totalPrice(),
                                          _orderListModel);
                                    },
                                    onSaved: (String val) {
                                      _submitOrderViewModel.amountPaid.text =
                                          val;
                                    },
                                  ),
                                  Divider(
                                    color: Colors.black45,
                                    thickness: 0.2,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "Debt amount :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "${_submitOrderViewModel.debt != null ? NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_submitOrderViewModel.debt)) : "0.00 DA"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Divider(
                                    color: Colors.black45,
                                    thickness: 0.2,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "Old Debts :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        " ${_submitOrderViewModel.isOverpaid == true ? "Overpaid" : _submitOrderViewModel.debtsPaid != null ? NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_submitOrderViewModel.debtsPaid)) : "0.00"} / ${_submitOrderViewModel.totalOldDebts != null ? NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_submitOrderViewModel.totalOldDebts)) : "0.00"} DA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black45,
                                    thickness: 0.2,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "New Debts :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        " ${_submitOrderViewModel.isOverpaid == true ? "Overpaid" : _submitOrderViewModel.newDebts != null ? NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_submitOrderViewModel.newDebts)) : "0.00"} DA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 0.2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Client Name:  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          "${_listeningtoDropBox.dropDownValueInchProviders}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Order Number:  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          "${_submitOrderViewModel.isSubmited == true ? (int.parse(_orderListModel.orderNumber)).toString().padLeft(6, '0') : (int.parse(_orderListModel.orderNumber) + 1).toString().padLeft(6, '0')}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Price:  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_orderListModel.totalPrice()))} DA",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Debt amount :  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(_submitOrderViewModel.debt))} DA",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          color: Colors.black45,
                          thickness: 0.2,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red.shade300,
                                    textStyle: TextStyle(fontSize: 18),
                                    shape: StadiumBorder()),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 60,
                                    child: Text('Close')),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: 200,
                            )),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              child: _submitOrderViewModel.isPrintOk == false
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green.shade300,
                                          textStyle: TextStyle(fontSize: 18),
                                          shape: StadiumBorder()),
                                      onPressed: () async {
                                        _submitOrderViewModel
                                            .loadingAnimation();

                                        _submitOrderViewModel
                                            .getFullOrder(context);
                                      },
                                      child: _submitOrderViewModel.isSubmited ==
                                              false
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 35,
                                              width: 60,
                                              child: Text('Submit'))
                                          : Container(
                                              height: 35,
                                              width: 60,
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  left: 17.5,
                                                  right: 17.5),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                    )
                                  : Container(
                                      child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green.shade300,
                                          textStyle: TextStyle(fontSize: 18),
                                          shape: StadiumBorder()),
                                      onPressed: () async {
                                        // print(
                                        //     " hadi hiya ${_submitOrderViewModel.harabhah[0].productName}");

                                        _invoiceViewModel.invoiceListItems =
                                            await _submitOrderViewModel
                                                .invoiceList();

                                        print(
                                            "fron the submition : ${_submitOrderViewModel.invoiceList()}");
                                        await _invoiceViewModel
                                            .generateInvoiceObject(context,
                                                _orderListModel.orderNumber);
                                        final pdfFile =
                                            await _pdfInvoiceApi.generate(
                                                _invoiceViewModel.invoice,
                                                _submitOrderViewModel.debt,
                                                context,
                                                _submitOrderViewModel
                                                    .amountPaid.text,
                                                _submitOrderViewModel
                                                    .totalOldDebts);

                                        await _pdfInvoiceApi.openFile(pdfFile);
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 35,
                                          width: 60,
                                          child: Text('Print')),
                                    )),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
