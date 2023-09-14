import 'dart:async';

import 'package:crdt/map_crdt.dart';
import 'package:hive/hive.dart';

export 'package:crdt/crdt.dart';

class HiveCrdt extends MapCrdtBase {
  final Map<String, Box<Record>> _boxes;

  @override
  bool get isEmpty => _boxes.values.fold(true, (p, e) => p && e.isEmpty);

  @override
  bool get isNotEmpty => !isEmpty;

  HiveCrdt._(super.tables, this._boxes);

  /// Create or open tables and store them in [path].
  /// Table names are used as file names.
  /// Use [prefix] to prepend the filename, otherwise Hive will prevent opening
  /// multiple boxes with the same tables. Useful for testing.
  static Future<HiveCrdt> open(Iterable<String> tables,
      {String? path, String? prefix}) async {
    assert(tables.isNotEmpty);
    assert(tables.length == tables.toSet().length);

    final boxes = {
      for (final table in tables)
        table: await Hive.openBox<Record>('${prefix ?? ''}_$table', path: path)
    };

    final crdt = HiveCrdt._(tables, boxes);
    return crdt;
  }

  /// Closes all tables
  Future<void> close() => Future.wait(_boxes.values.map((e) => e.close()));

  /// Deletes all data from every table
  Future<void> purge() => Future.wait(_boxes.values.map((e) => e.clear()));

  /// Deletes all tables from disk
  Future<void> delete() =>
      Future.wait(_boxes.values.map((e) => e.deleteFromDisk()));

  @override
  Record? getRecord(String table, String key) => _boxes[table]!.get(key);

  @override
  Map<String, Record> getRecords(String table) =>
      _boxes[table]!.toMap().cast<String, Record>();

  @override
  Future<void> putRecords(Map<String, Map<String, Record>> dataset) async {
    for (final entry in dataset.entries) {
      await _boxes[entry.key]!.putAll(entry.value);
    }
  }

  @override
  Stream<({String key, dynamic value})> watch(String table, {String? key}) {
    if (!tables.contains(table)) throw 'Unknown table: $table';
    return _boxes[table]!
        .watch(key: key)
        .map((event) => (key: event.key, value: event.value?.value));
  }
}
