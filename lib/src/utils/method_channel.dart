import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/locator.dart';

///Binds method names to method calls with parameter unloading
class JsonMethodChannel {
  Function? dismiss;

  void registerDismissListener(Function dismiss) {
    if (this.dismiss != null) return;
    this.dismiss = dismiss;
  }

  //invokes method associated with `methodName`
  void invokeMethod(String? methodName, {ApiRequest? params}) {
    switch (methodName) {
      case kMakeRequest:
        assert(params != null);
        _makeNetworkRequest(params!);
        break;
      case kDismissPage:
        _dismissPage();
        break;
      default:
    }
  }

  //Makes network request
  Future<dynamic>? _makeNetworkRequest(ApiRequest requestParams) async {
    await locator<HttpService>().sendNetworkRequest(
        requestParams.url, requestParams.type,
        body: requestParams.body, headers: requestParams.headers);
  }

  //dismisses JsonUI page
  void _dismissPage() {
    dismiss!();
  }
}
