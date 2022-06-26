import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

import '../logger.dart';

requestInterceptor(Request request) {
  if (kDebugMode) {
    var message = {
      'REQUEST URL:': request.url,
      'REQUEST HEADER:': request.headers,
      'REQUEST METHOD:': request.method,
      'REQUEST BODY':request.bodyBytes
    };
    logger.i(message);
  }
  return request;
}


responseInterceptor(Request request, Response response) {
  var message = <String, dynamic>{
    'RESPONSE URL:': request.url,
    'RESPONSE CODE:': response.statusCode,
    'RESPONSE MESSAGE:': response.statusText,
    'RESPONSE BODY:': response.body,
    'RESPONSE UNAUTHORIZED:': response.unauthorized,
  };
  logger.i(message);
  GetStorage().write(request.url.toString(),response.body);
  print("");
  return response;
}