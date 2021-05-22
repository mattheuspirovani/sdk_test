class RpcAccount {
  String address;
  bool hasKey;
  String label;
  bool watchOnly;

  Map<String, dynamic> toJson() => {
        'address': address,
        'hasKey': hasKey,
        'label': label,
        'watchOnly': watchOnly
      };

  RpcAccount.fromJson(Map<String, dynamic> json)
      : address = json["address"],
        hasKey = json["hasKey"],
        label = json["label"],
        watchOnly = json["watchOnly"];
}
