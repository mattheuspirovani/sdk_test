import 'package:neo_sdk/sdk/rpc/models/rpc_method_token.dart';

class RPCNef {
  int magic;
  String compiler;
  String script;
  int checksum;
  List<RPCMethodToken> tokens;
}
