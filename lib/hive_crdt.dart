import 'package:crdt/crdt.dart';
import 'package:hive/hive.dart';

export 'package:crdt/crdt.dart';

class HiveCrdt<K, V> extends Crdt<K, V> {
  @override
  final String nodeId;
  final Box<Record> _box;

  HiveCrdt(Box<Record> box, this.nodeId) : _box = box;

  static Future<HiveCrdt<K, V>> open<K, V>(String name, String nodeId,
      {String? path}) async {
    final box = await Hive.openBox<Record>(name, path: path);
    return HiveCrdt<K, V>(box, nodeId);
  }

  @override
  bool containsKey(K key) => _box.containsKey(_encode(key));

  @override
  Record<V>? getRecord(K key) => _box.get(_encode(key)) as Record<V>?;

  @override
  void putRecord(K key, Record<V> record) => _box.put(_encode(key), record);

  @override
  void putRecords(Map<K, Record<V>> recordMap) => _box.putAll(recordMap);

  @override
  Map<K, Record<V>> recordMap({Hlc? modifiedSince}) => (_box.toMap()
        ..removeWhere((_, record) =>
            record.modified.logicalTime < (modifiedSince?.logicalTime ?? 0)))
      .map((key, value) => MapEntry(_decode(key), value as Record<V>));

  @override
  Stream<MapEntry<K, V?>> watch({K? key}) => _box
      .watch(key: key)
      .map((event) => MapEntry<K, V>(event.key, event.value.value));

  @override
  void purge() => _box.clear();

  Future<void> close() => _box.close();

  /// Permanently deletes the store from disk. Useful for testing.
  Future<void> deleteStore() => _box.deleteFromDisk();

  dynamic _encode(K key) =>
      key is DateTime ? key.toUtc().toIso8601String() : key;

  K _decode(dynamic key) => K == DateTime ? DateTime.parse(key) : key;
}
