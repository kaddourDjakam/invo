import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/addProductViewModel.dart';
import 'package:inventory/ViewModel/clientsViewModel.dart';
import 'package:inventory/ViewModel/orderViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:provider/provider.dart';

class OrderDataMayLoss extends StatefulWidget {
  @override
  _OrderDataMayLossState createState() => new _OrderDataMayLossState();
}

SubmitOrderViewModel _submitOrderViewModel;
OrderViewModel _orderListModel;
ListeningtoDropBox _listeningtoDropBox;
ClientViewModel _clientViewModel;

class _OrderDataMayLossState extends State<OrderDataMayLoss> {
  @override
  void dispose() {
    _orderListModel.listOfOrders = null;
    _orderListModel.orderList = [];
    _orderListModel.orderNumber = null;
    _orderListModel.message = null;
    _submitOrderViewModel.isPrintOk = false;
    _submitOrderViewModel.isSubmited = false;
    _submitOrderViewModel.json = null;
    _submitOrderViewModel.debt = null;
    _submitOrderViewModel.amountPaid.text = "";
    _listeningtoDropBox.dropDownValueInchProviders = null;
    _listeningtoDropBox
        .providersText(_listeningtoDropBox.dropDownValueInchProviders);
    _clientViewModel.clients = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listeningtoDropBox =
        Provider.of<ListeningtoDropBox>(context, listen: true);
    _orderListModel = Provider.of<OrderViewModel>(context, listen: true);
    _submitOrderViewModel =
        Provider.of<SubmitOrderViewModel>(context, listen: true);
    return Container(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Hero(
          tag: "Order",
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "the data of the last order will be deleted !!",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade300,
                        textStyle: TextStyle(fontSize: 18),
                        shape: StadiumBorder()),
                    child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 60,
                        child: Text('OK')),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
