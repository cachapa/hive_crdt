import 'package:hive/hive.dart';
import 'package:hive_crdt/src/hive_adapters.dart';
import 'package:hive_crdt/src/hive_crdt.dart';

Future<void> main() async {
  // Initialize Hive
  Hive
    ..init('test_store')
    ..registerAdapter(RecordAdapter(42));

  var crdt1 = await HiveCrdt.open(prefix: 'crdt1', ['table']);
  var crdt2 = await HiveCrdt.open(prefix: 'crdt2', ['table']);

  print('Inserting 2 records in crdt1…');
  await crdt1.put('table', 'a', 1);
  await crdt1.put('table', 'b', 1);

  print('crdt1: ${crdt1.getMap('table')}');

  print('\nInserting a conflicting record in crdt2…');
  await crdt2.put('table', 'a', 2);

  print('crdt2: ${crdt2.getMap('table')}');

  print('\nMerging crdt2 into crdt1…');
  await crdt1.merge(crdt2.getChangeset());

  print('crdt1: ${crdt1.getMap('table')}');
}
