import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/locator.dart';

///Binds method names to method calls with parameter unloading
class JsonMethodChannel {
  Function? dismiss;

  void registerDismissListener(Function dismiss) {
    this.dismiss = dismiss;
  }

  ///invokes method associated with `methodName`
  Future<Object?> invokeMethod(
    String? methodName, {
    ApiRequest? params,
  }) async {
    switch (methodName) {
      case kMakeRequest:
        assert(params != null);
        return await _makeNetworkRequest(params!);
      case kDismissPage:
        _dismissPage();
        break;
      default:
        print("Unknown method name: $methodName");
    }
  }

  ///Makes network request
  Future<Map<String, dynamic>?> _makeNetworkRequest(
    ApiRequest requestParams,
  ) async {
    return await locator<HttpService>().sendNetworkRequest(
      requestParams.url,
      requestParams.type,
      body: requestParams.body,
      headers: requestParams.headers,
    );
  }

  //dismisses JsonUI page
  void _dismissPage() {
    if (dismiss != null) {
      dismiss!();
    }
  }
}
