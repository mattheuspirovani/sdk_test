import 'package:neo_sdk/sdk/rpc/util/constants.dart';

class RPCRequest {
  String jsonrpc;
  String method;
  dynamic params;
  int id;
  RPCRequest(this.method,
      {this.id = Constants.RPC_ID,
      this.params = const [],
      this.jsonrpc = Constants.RPC_JSON});
  Map<String, dynamic> toMap() {
    return {"jsonrpc": jsonrpc, "method": method, "params": params, "id": id};
  }
}
