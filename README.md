# hive_crdt

A CRDT backed by a [Hive](https://pub.dev/packages/hive) store.

Depends on the [crdt](https://pub.dev/packages/crdt) package.

## Usage

A simple usage example:

```dart
import 'package:hive_crdt/hive_crdt.dart';

// TODO: Generate id on first launch
const nodeId = 'random_id';

main() async {
  var crdt = await HiveCrdt.open('test', nodeId);
  crdt.put('x', 1);
  crdt.get('x');  // 1
}
```
