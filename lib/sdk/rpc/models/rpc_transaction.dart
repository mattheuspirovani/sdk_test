import 'dart:ffi';

import 'package:neo_sdk/sdk/rpc/models/signer.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_witness.dart';

class RPCTransaction {
  String hash;
  int size;
  BigInt version;
  BigInt nonce;
  String sender;
  double sysfee;
  double netfee;
  BigInt validUntilBlock;
  List<Signer> signers;
  String script;
  List<RPCWitness> witnesses;
  String blockHash;
  int confirmations;
  int blockTime;
}
