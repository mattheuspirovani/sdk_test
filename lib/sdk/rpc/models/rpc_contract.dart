import 'package:neo_sdk/sdk/rpc/models/rpc_manifest.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_nef.dart';

class RpcContract {
  int id;
  int updatecounter;
  String hash;
  RPCNef nef;
  RPCManifest manifest;
  List<int> updateHistory;
}
