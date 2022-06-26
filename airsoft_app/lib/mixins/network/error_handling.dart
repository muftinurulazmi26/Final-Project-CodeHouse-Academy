import 'package:airsoft_app/model/res/error_res.dart';
import 'package:get/get.dart';

class ErrorHandling {
  int code = 0;
  String message = "";

  ErrorHandling(response) {
    if (response is Response) {
      code = response.statusCode!;
    }
    message = getErrorMessage(response);
  }

  static String getErrorMessage(response) {
    try {
      if (response is Response) {
        if (response.body != null) {
          return ErrorRes.fromJson(response.body).statusMessage!;
        } else {
          switch (response.statusCode) {
            case 200:
              return "Login Success";
            case 400:
              return "Email is required";
            case 403:
              return "Forbidden Access";
            case 500:
              return "Internal Server Error";
            default:
              if (response.statusText != null &&
                  response.statusText!.isNotEmpty) {
                return response.statusText!;
              }
              return 'Unknown error.';
          }
        }
      } else {
        return response.toString();
      }
    } catch (e) {
      return response.toString();
    }
  }

  @override
  String toString() {
    return message;
  }
}
