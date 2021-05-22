class RpcNep17Transfers {
  BigInt userScriptHash;
  List<RpcNep17Transfer> sent;
  List<RpcNep17Transfer> received;
}

class RpcNep17Transfer {
  BigInt timestampMS;
  BigInt assetHash;
  BigInt userScriptHash;
  BigInt amount;
  BigInt blockIndex;
  BigInt transferNotifyIndex;
  String txHash;
}
