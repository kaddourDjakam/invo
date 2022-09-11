import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/addCategoryViewModel.dart';
import 'package:provider/provider.dart';

class AddNewCategoryView extends StatefulWidget {
  @override
  _AddNewCategoryViewState createState() => _AddNewCategoryViewState();
}

class _AddNewCategoryViewState extends State<AddNewCategoryView> {
  @override
  Widget build(BuildContext context) {
    AddCategoryViewModel _addCategoryViewModel =
        Provider.of<AddCategoryViewModel>(context, listen: true);
    // final categoryKeyForm = GlobalKey<FormState>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "category",
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
                      "Add New Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _addCategoryViewModel.categoryKeyForm,
                      child: Column(
                        children: [
                          FutureBuilder(
                              // future: _addCategoryViewModel.validateInputs(
                              //     categoryKeyForm, context),
                              builder: (context, snapshot) {
                            return Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Category Name',
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.green,
                                controller: _addCategoryViewModel.nameCategory,
                                validator:
                                    _addCategoryViewModel.validateThetext,
                                onChanged: (__) {},
                                onSaved: (String val) {
                                  _addCategoryViewModel.nameCategory.text = val;
                                },
                              ),
                            );
                          }),
                          Divider(
                            color: Colors.black45,
                            thickness: 0.2,
                          ),
                          Text("Category Are Exsist Already!!",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: _addCategoryViewModel.erorrColor)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              ElevatedButton(
                                /*shape: StadiumBorder(),*/
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              Expanded(
                                  child: Container(
                                width: 200,
                              )),
                              // ignore: deprecated_member_use
                              ElevatedButton(
                                /* shape: StadiumBorder(),*/
                                onPressed: () {
                                  //print(_addCategoryViewModel.categoryName.text);
                                  _addCategoryViewModel
                                      .validationCategory(context);
                                },
                                child: Text("Submit"),
                              )
                            ],
                          ),
                        ],
                      ),
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
