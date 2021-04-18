import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';

///Binds method names to method calls with parameter unloading
class JsonMethodChannel {
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
  Future<dynamic>? _makeNetworkRequest(ApiRequest requestParams) {}

  //dismisses Json to Flutter  UI page
  void _dismissPage() {}
}
