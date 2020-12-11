import 'package:crdt_hive/crdt_hive.dart';

// TODO: Generate id on first launch
const nodeId = 'random_id';

Future<void> main() async {
  var crdt = await CrdtHive.open('test', nodeId);
  crdt.put('a', 1);
  print(crdt.get('a')); // 1
}
