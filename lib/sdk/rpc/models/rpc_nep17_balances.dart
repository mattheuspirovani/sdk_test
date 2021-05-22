class RPCNep17Balances {
  BigInt userScriptHash;
  List<RPCNep17Balance> balances;
}

class RPCNep17Balance {
  BigInt assetHash;
  BigInt amount;
  BigInt lastUpdatedBlock;
}
