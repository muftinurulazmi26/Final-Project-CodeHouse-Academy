import 'package:airsoft_app/mixins/logger.dart';
import 'package:airsoft_app/mixins/server.dart';
import 'package:airsoft_app/model/res/product_res.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../mixins/constant.dart';
import '../mixins/network/error_handling.dart';
import '../mixins/network/interceptor.dart';
import '../model/auth.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    allowAutoSignedCert = true;
    httpClient.baseUrl = Server.baseUrl;
    httpClient.timeout = const Duration(milliseconds: kConnectionTimeout);
    httpClient.addRequestModifier((request) {
      return requestInterceptor(request);
    });
    httpClient.addResponseModifier((request, response) {
      return responseInterceptor(request, response);
    });
  }

  Future<Auth> doLogin(Map<String, dynamic> login) async {
    final response = await post('auth/login', login);
    try {
      return Auth.fromJson(response.body);
    } catch (e, s) {
      logger.e('auth', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return Auth.fromJson(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<Auth> doRegister(Map<String, dynamic> register) async {
    final response = await post('auth/register', register);
    try {
      return Auth.fromJson(response.body);
    } catch (e, s) {
      logger.e('auth', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return Auth.fromJson(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<ProductRes> addProduct(FormData product, String token) async {
    final header = {
      "Authorization": "Bearer $token",
    };

    final response = await post(
      'airsoft/add',
      product,
      headers: header,
    );
    try {
      return ProductRes.fromJsonAdd(response.body);
    } catch (e, s) {
      logger.e('auth', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return ProductRes.fromJsonAdd(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<ProductRes> editProduct(FormData product, String token) async {
    final header = {
      "Authorization": "Bearer $token",
    };

    final response = await post(
      'airsoft/update',
      product,
      headers: header,
    );
    try {
      return ProductRes.fromJsonUpdate(response.body);
    } catch (e, s) {
      logger.e('auth', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return ProductRes.fromJsonUpdate(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<ProductRes> deleteProduct(int id, String token) async {
    final header = {
      "Authorization": "Bearer $token",
    };

    final response = await delete(
      'airsoft/delete/$id',
      headers: header,
    );

    try {
      return ProductRes.fromJsonDelete(response.body);
    } catch (e, s) {
      logger.e('deleteAirsoftProduct', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return ProductRes.fromJsonDelete(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<ProductRes> getProduct(int page, String token) async {
    final header = {
      "Authorization": "Bearer $token",
    };

    final response = await get(
      'airsoft',
      headers: header,
      query: {
        "page": "$page",
      },
    );

    try {
      return ProductRes.fromJsonGet(response.body);
    } catch (e, s) {
      logger.e('getAirsoftProduct', e, s);
      if (response.hasError) {
        if (GetStorage().hasData(response.request!.url.toString())) {
          Map<String, dynamic> responseCache =
              GetStorage().read(response.request!.url.toString());
          return ProductRes.fromJsonGet(responseCache);
        }
        return Future.error(ErrorHandling(response));
      } else {
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }
}
