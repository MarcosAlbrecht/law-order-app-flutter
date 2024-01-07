import 'package:app_law_order/src/models/service_model.dart';

class OrderServiceModel {
  List<ServiceModel>? service;
  double? total;

  OrderServiceModel({
    this.service,
    this.total = 0.0,
  });
}
