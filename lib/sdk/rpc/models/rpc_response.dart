import 'package:neo_sdk/sdk/rpc/models/rpc_response_error.dart';

class RPCResponse<T> {
  String jsonrpc;
  int id;
  T result;
  RPCErrorResponse error;

  RPCResponse.fromJson(Map<String, dynamic> json)
      : jsonrpc = json["jsonrpc"],
        id = json["id"],
        result = json["result"];
}
