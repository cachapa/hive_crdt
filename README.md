# CRDT Hive

A CRDT backed by a [Hive](https://pub.dev/packages/hive) store.

Depends on [crdt](https://github.com/cachapa/crdt)

## Usage

A simple usage example:

```dart
import 'package:crdt_hive/crdt_hive.dart';

// TODO: Generate id on first launch
const nodeId = 'random_id';

main() async {
  var crdt = await CrdtHive.open('test', nodeId);
  crdt.put('x', 1);
  crdt.get('x');  // 1
}
```
