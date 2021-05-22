import 'package:neo_sdk/sdk/rpc/models/rpc_witness.dart';

class RPCStateRoot {
  BigInt version;
  BigInt index;
  String rootHash;
  RPCWitness witness;
}
