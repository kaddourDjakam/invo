import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/addClientViewModel.dart';
import 'package:inventory/ViewModel/addProviderViewModel.dart';
import 'package:provider/provider.dart';

class AddClientView extends StatefulWidget {
  @override
  _AddClientViewState createState() => _AddClientViewState();
}

AddClientViewModel _addClientViewModel;

class _AddClientViewState extends State<AddClientView> {
  @override
  Widget build(BuildContext context) {
    _addClientViewModel =
        Provider.of<AddClientViewModel>(context, listen: true);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "addClient",
          /* createRectTween: (begin, end) {
                return CustomRectTween(begin: begin, end: end);
              },*/
          child: Material(
            color: Color(0xffEEEEEE),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Order Number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _addClientViewModel.clientKeyForm,
                      child: FutureBuilder(builder: (context, snapshot) {
                        return Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Name Of Client',
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.green,
                                controller: _addClientViewModel.clientName,
                                validator: _addClientViewModel.validateThetext,
                                onChanged: (__) {},
                                onSaved: (String val) {
                                  _addClientViewModel.clientName.text = val;
                                }),
                            Divider(
                              color: Colors.black45,
                              thickness: 0.2,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.green,
                              controller: _addClientViewModel.clientPhone,
                              validator: _addClientViewModel.validateThePhone,
                              onChanged: (__) {},
                              onSaved: (String val) {
                                _addClientViewModel.clientPhone.text = val;
                              },
                            ),
                            Divider(
                              color: Colors.black45,
                              thickness: 0.2,
                            ),
                            Text("This Provider Are Exsist Already!!",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: _addClientViewModel.erorrColor)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  // shape: StadiumBorder(),
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
                                  // shape: StadiumBorder(),
                                  onPressed: () async {
                                    await _addClientViewModel
                                        .validationprovider(context);
                                    print(
                                        "From The Btn ${_addClientViewModel.erorrColor}");
                                    if (_addClientViewModel.erorrColor ==
                                            Color(0xfff44336) ||
                                        _addClientViewModel.erorrColor ==
                                            Colors.red) {
                                      print(123.toString().padLeft(6, '0'));
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Submit"),
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
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
