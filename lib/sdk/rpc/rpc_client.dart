import 'dart:convert' as convert;
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:neo_sdk/sdk/rpc/models/rpc_block.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_contract.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_request.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_response.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_signer.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_stack.dart';
import 'package:neo_sdk/sdk/rpc/models/rpc_transaction.dart';
import 'package:neo_sdk/sdk/rpc/util/constants.dart';

import 'models/rcp_nep17_transfers.dart';
import 'models/rpc_account.dart';
import 'models/rpc_invoke_result.dart';
import 'models/rpc_nep17_balances.dart';
import 'models/rpc_node_version.dart';
import 'models/rpc_peer_state.dart';
import 'models/rpc_plugin.dart';
import 'models/rpc_state_root.dart';
import 'models/rpc_transaction_pool.dart';
import 'models/rpc_transfer_out.dart';
import 'models/rpc_unclaimed_gas.dart';
import 'models/rpc_validate_address_result.dart';
import 'models/rpc_validator.dart';

class RPCClient {
  final String net;
  RPCClient(this.net, {String version = Constants.RPC_VERSION}) {}

  Future<RPCResponse<TResponse>> execute<TResponse>(
      RPCRequest rpcRequest) async {
    final uri = Uri.https(this.net, "");
    final headers = Map<String, String>();
    headers["Content-Type"] = "application/json";
    final response = await http.post(uri,
        headers: headers, body: convert.jsonEncode(rpcRequest.toMap()));
    if (response.statusCode == 200) {
      return RPCResponse<TResponse>.fromJson(convert.jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  //BLOCKCHAIN
  Future<String> getBestBlockHash() async {
    final rpcRequest = RPCRequest("getbestblockhash");
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCBlock> getBlock(dynamic indexOrHash) async {
    final rpcRequest = RPCRequest("getblock", params: [indexOrHash, true]);
    final rcpResponse = await execute<RPCBlock>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getBlockHex(dynamic indexOrHash) async {
    final rpcRequest = RPCRequest("getblock", params: [indexOrHash, false]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<int> getBlockCount() async {
    final rpcRequest = RPCRequest("getblockcount");
    final rcpResponse = await execute<int>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getBlockHash(int index) async {
    final rpcRequest = RPCRequest("getblockhash", params: [index]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCBlock> getBlockHeader(dynamic indexOrHash) async {
    final rpcRequest =
        RPCRequest("getblockheader", params: [indexOrHash, true]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getBlockHeaderHex(dynamic indexOrHash) async {
    final rpcRequest =
        RPCRequest("getblockheader", params: [indexOrHash, false]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result;
  }

  Future<List<String>> getCommittee() async {
    final rpcRequest = RPCRequest("getcommittee");
    final rcpResponse = await execute<List<String>>(rpcRequest);
    return rcpResponse.result;
  }

  //TODO
  Future<List<RpcContract>> getNativeContracts() async {
    final rpcRequest = RPCRequest("getnativecontracts");
    final rcpResponse = await execute<List<RpcContract>>(rpcRequest);
    return rcpResponse.result;
  }

  Future<List<RPCValidator>> getNextBlockValidators() async {
    final rpcRequest = RPCRequest("getnextblockvalidators");
    final rcpResponse = await execute<List<RPCValidator>>(rpcRequest);
    return rcpResponse.result;
  }

  Future<List<RpcContract>> getContractstate() async {
    final rpcRequest = RPCRequest("getcontractstate");
    final rcpResponse = await execute<List<RpcContract>>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCTransactionPool> getRawMempool(
      {bool allTransactions = false}) async {
    final rpcRequest = RPCRequest("getrawmempool", params: [allTransactions]);
    RPCTransactionPool rpcTransactionPool = RPCTransactionPool();
    if (!allTransactions) {
      final rcpResponse = await execute<List<String>>(rpcRequest);
      rcpResponse.result
          .map((e) => rpcTransactionPool.verified.add(e))
          .toList();
    } else {
      rpcTransactionPool =
          (await execute<RPCTransactionPool>(rpcRequest)).result;
    }
    return rpcTransactionPool;
  }

  Future<RPCTransaction> getRawTransaction(String txId) async {
    final rpcRequest = RPCRequest("getrawtransaction", params: [txId, true]);
    final rcpResponse = await execute<RPCTransaction>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getRawTransactionHex(String txId) async {
    final rpcRequest = RPCRequest("getrawtransaction", params: [txId, false]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getStorage(String scriptHash, String key) async {
    final rpcRequest = RPCRequest("getstorage", params: [scriptHash, key]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<int> getTransactionHeight(String txId) async {
    final rpcRequest = RPCRequest("gettransactionheight", params: [txId]);
    final rcpResponse = await execute<int>(rpcRequest);
    return rcpResponse.result;
  }
  //END BLOCKCHAIN

  //NODE
  Future<int> getConnectionCount() async {
    final rpcRequest = RPCRequest("getconnectioncount");
    final rcpResponse = await execute<int>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCPeerState> getPeers() async {
    final rpcRequest = RPCRequest("getpeers");
    final rcpResponse = await execute<RPCPeerState>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCNodeVersion> getVersion() async {
    final rpcRequest = RPCRequest("getversion");
    final rcpResponse = await execute<RPCNodeVersion>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> sendRawTransaction(String txId) async {
    final rpcRequest = RPCRequest("sendrawtransaction", params: [txId]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result.hash;
  }

  Future<String> submitBlock(String block) async {
    final rpcRequest = RPCRequest("submitblock", params: [block]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result.hash;
  }
  //END NODE

  //SMARTCONTRACT
  Future<RPCUnclaimedGas> getUnclaimedGas(String address) async {
    final rpcRequest = RPCRequest("getunclaimedgas", params: [address]);
    final rcpResponse = await execute<RPCUnclaimedGas>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCInvokeResult> invokeFunction(String scriptHash, String operation,
      List<RPCStack> contractParams, List<RPCSigner> signers) async {
    final rpcRequest = RPCRequest("invokefunction",
        params: [scriptHash, operation, contractParams, signers]);
    final rcpResponse = await execute<RPCInvokeResult>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCInvokeResult> invokeScript(
      String scriptHash, List<RPCSigner> signers) async {
    final rpcRequest =
        RPCRequest("invokescript", params: [scriptHash, signers]);
    final rcpResponse = await execute<RPCInvokeResult>(rpcRequest);
    return rcpResponse.result;
  }
  //END SMARTCONTRACT

  //TOOL
  Future<List<RPCPlugin>> listPlugins() async {
    final rpcRequest = RPCRequest("listplugins");
    final rcpResponse = await execute<List<RPCPlugin>>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCValidateAddressResult> validateAddress(String address) async {
    final rpcRequest = RPCRequest("validateaddress", params: [address]);
    final rcpResponse = await execute<RPCValidateAddressResult>(rpcRequest);
    return rcpResponse.result;
  }
  //END TOOL

  //WALLET
  Future<BigInt> calculateNetworkFee(String txId) async {
    final rpcRequest = RPCRequest("calculatenetworkfee", params: [txId]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result.networkfee;
  }

  Future<bool> closeWallet() async {
    final rpcRequest = RPCRequest("closewallet");
    final rcpResponse = await execute<bool>(rpcRequest);
    return rcpResponse.result;
  }

  Future<bool> dumpPrivkey(String address) async {
    final rpcRequest = RPCRequest("dumpprivkey", params: [address]);
    final rcpResponse = await execute<bool>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getNewAddress() async {
    final rpcRequest = RPCRequest("getnewaddress");
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getWalletBalance(String assetId) async {
    final rpcRequest = RPCRequest("getwalletbalance", params: [assetId]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result.balance;
  }

  Future<String> getWalletUnclaimedGas() async {
    final rpcRequest = RPCRequest("getwalletunclaimedgas");
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RpcAccount> importPrivkey(String wif) async {
    final rpcRequest = RPCRequest("importprivkey", params: [wif]);
    final rcpResponse = await execute<RpcAccount>(rpcRequest);
    return rcpResponse.result;
  }

  Future<dynamic> invokeContractVerify(
      String scriptHash, dynamic contractParams, dynamic signers) async {
    final rpcRequest = RPCRequest("invokecontractverify",
        params: [scriptHash, contractParams, signers]);
    final rcpResponse = await execute<dynamic>(rpcRequest);
    return rcpResponse.result;
  }

  Future<List<RpcAccount>> listAddress() async {
    final rpcRequest = RPCRequest("listaddress");
    final rcpResponse = await execute<List<RpcAccount>>(rpcRequest);
    return rcpResponse.result;
  }

  Future<bool> openWallet(String path, String password) async {
    final rpcRequest = RPCRequest("openwallet", params: [path, password]);
    final rcpResponse = await execute<bool>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCTransaction> sendFrom(
      String assetId, String addressFrom, String addressTo, Int64 value) async {
    final rpcRequest = RPCRequest("sendfrom",
        params: [assetId, addressFrom, addressTo, value]);
    final rcpResponse = await execute<RPCTransaction>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCTransaction> sendMany(
      String from, List<RPCTransferOut> assets) async {
    final rpcRequest = RPCRequest("sendmany", params: [from, assets]);
    final rcpResponse = await execute<RPCTransaction>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RPCTransaction> sendToAddress(
      String assetId, String address, Int64 value) async {
    final rpcRequest =
        RPCRequest("sendtoaddress", params: [assetId, address, value]);
    final rcpResponse = await execute<RPCTransaction>(rpcRequest);
    return rcpResponse.result;
  }
  //END WALLET

  //APPLICATION LOGS
  Future<RPCTransaction> getApplicationLog(
      String from, List<RPCTransferOut> assets) async {
    final rpcRequest = RPCRequest("sendmany", params: [from, assets]);
    final rcpResponse = await execute<RPCTransaction>(rpcRequest);
    return rcpResponse.result;
  }
  //END APPLICATION LOGS

  //RPCNEP17TRACKER
  Future<RPCNep17Balances> getNep17Balances(String address) async {
    final rpcRequest = RPCRequest("getnep17balances", params: [address]);
    final rcpResponse = await execute<RPCNep17Balances>(rpcRequest);
    return rcpResponse.result;
  }

  Future<RpcNep17Transfers> getNep17Transfers(String address,
      {int startTime, int endTime}) async {
    final rpcRequest =
        RPCRequest("getnep17transfers", params: [address, startTime, endTime]);
    final rcpResponse = await execute<RpcNep17Transfers>(rpcRequest);
    return rcpResponse.result;
  }
  //END RPCNEP17TRACKER

  //STATESERVICE
  Future<RPCStateRoot> getStateRoot(int blockIndex) async {
    final rpcRequest = RPCRequest("getstateroot", params: [blockIndex]);
    final rcpResponse = await execute<RPCStateRoot>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getProof(
      String rootHash, String scriptHash, String key) async {
    final rpcRequest =
        RPCRequest("getproof", params: [rootHash, scriptHash, key]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> verifyProof(String rootHash, String proof) async {
    final rpcRequest = RPCRequest("verifyproof", params: [rootHash, proof]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }

  Future<String> getStateHeight(String rootHash, String proof) async {
    final rpcRequest = RPCRequest("getstateheight", params: [rootHash, proof]);
    final rcpResponse = await execute<String>(rpcRequest);
    return rcpResponse.result;
  }
  //END STATESERVICE
}
