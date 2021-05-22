import 'package:neo_sdk/sdk/rpc/models/rpc_transaction.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_witness.dart';

class RPCBlock {
  String hash;
  int size;
  int version;
  String previousBlockHash;
  String merkleRoot;
  int time;
  int index;
  int primary;
  String nextConsensus;
  List<RPCWitness> witnesses;
  List<RPCTransaction> tx;
}
