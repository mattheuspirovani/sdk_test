class RpcApplicationLog {
  String txId;
  String blockHash;
  List<Execution> executions;
}

class Execution {
  String trigger;
  String vmState;
  BigInt gasConsumed;
  dynamic stack;
  List<RpcNotifyEventArgs> notifications;
}

class RpcNotifyEventArgs {
  String contract;
  String eventName;
  dynamic state;
}
