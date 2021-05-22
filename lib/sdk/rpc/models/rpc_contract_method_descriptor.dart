import 'package:neo_sdk/sdk/rpc/models/rpc_contract_parameter_definition.dart';

class RPCContractMethodDescriptor {
  String name;
  String returnType;
  int offset;
  bool safe;
  List<RPCContractParameterDefinition> parameters;
}
