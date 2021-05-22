import 'package:neo_sdk/sdk/rpc/models/rpc_stack.dart';

class RPCInvokeResult {
  String script;
  int vmState;
  BigInt gasConsumed;
  List<RPCStack> stack;
  String tx;
  String exception;
}
