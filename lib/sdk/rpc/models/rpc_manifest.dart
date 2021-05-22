import 'package:neo_sdk/sdk/rpc/models/rpc_abi.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_contract_permission.dart';

class RPCManifest {
  String name;
  dynamic groups;
  dynamic supportedstandards;
  RPCAbi abi;
  List<RPCContractPermission> permissions;
  dynamic trusts;
  dynamic extra;
}
