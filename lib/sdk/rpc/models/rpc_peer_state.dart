import 'package:neo_sdk/sdk/rpc/models/rpc_node.dart';

class RPCPeerState {
  List<RPCNode> unconnected;
  List<RPCNode> bad;
  List<RPCNode> connected;
}
