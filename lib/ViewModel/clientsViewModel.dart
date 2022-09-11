import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/services/ApiService.dart';

class ClientViewModel extends ChangeNotifier {
  List<ProviderModel> clients;
  ServiceAPI serviceAPI = new ServiceAPI();

  getClients() {
    return clients;
  }
}
