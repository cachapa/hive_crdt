import 'package:crdt_hive/hive_crdt.dart';

// TODO: Generate id on first launch
const nodeId = 'random_id';

Future<void> main() async {
  var crdt = await HiveCrdt.open('test', nodeId);
  crdt.put('a', 1);
  print(crdt.get('a')); // 1
}
