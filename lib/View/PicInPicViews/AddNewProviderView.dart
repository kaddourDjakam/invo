import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/addProviderViewModel.dart';
import 'package:provider/provider.dart';

class AddNewProviderView extends StatefulWidget {
  @override
  _AddNewProviderViewState createState() => _AddNewProviderViewState();
}

class _AddNewProviderViewState extends State<AddNewProviderView> {
  @override
  Widget build(BuildContext context) {
    AddProviderViewModel _addProviderViewModel =
        Provider.of<AddProviderViewModel>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "anme",
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
                      "Add New Provider",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _addProviderViewModel.providerKeyForm,
                      child: FutureBuilder(builder: (context, snapshot) {
                        return Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.green,
                                controller: _addProviderViewModel.name,
                                validator:
                                    _addProviderViewModel.validateThetext,
                                onChanged: (__) {},
                                onSaved: (String val) {
                                  _addProviderViewModel.name.text = val;
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
                              controller: _addProviderViewModel.phoneNum,
                              validator: _addProviderViewModel.validateThePhone,
                              onChanged: (__) {},
                              onSaved: (String val) {
                                _addProviderViewModel.phoneNum.text = val;
                              },
                            ),
                            Divider(
                              color: Colors.black45,
                              thickness: 0.2,
                            ),
                            Text("This Provider Are Exsist Already!!",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: _addProviderViewModel.erorrColor)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  /* shape: StadiumBorder(),*/
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
                                  /* shape: StadiumBorder(),*/
                                  onPressed: () {
                                    _addProviderViewModel
                                        .validationprovider(context);
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
