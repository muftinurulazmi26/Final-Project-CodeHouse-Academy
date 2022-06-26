import 'package:airsoft_app/model/product.dart';

class ProductRes {
  bool? success;
  String? message;
  Product? resultsAdd;
  List<Product>? resultsGet;

  ProductRes({this.success, this.message, this.resultsAdd, this.resultsGet});

  ProductRes.fromJsonAdd(Map<String, dynamic> json) {
    success = json['success'];
    if (success!) {
      resultsAdd = Product.fromJson(json['data']);
    }
    message = json['message'];
  }

  ProductRes.fromJsonUpdate(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  ProductRes.fromJsonDelete(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  ProductRes.fromJsonGet(Map<String, dynamic> json) {
    success = json['success'];
    if (success!) {
      resultsGet = <Product>[];
      json['data']['results'].forEach((v) {
        resultsGet!.add(Product.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (resultsAdd != null) {
      data['data'] = resultsAdd!.toJson();
    }
    data['message'] = message;

    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;

    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;

    return data;
  }

  Map<String, dynamic> toJsonGet() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (resultsGet != null) {
      data['data'] = resultsGet!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;

    return data;
  }
}
