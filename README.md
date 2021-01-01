# crdt_hive

A CRDT backed by a [Hive](https://pub.dev/packages/hive) store.

Depends on the [crdt](https://pub.dev/packages/crdt) package.

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
