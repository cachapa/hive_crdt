import 'package:crdt/crdt.dart';
import 'package:hive/hive.dart';

class HlcAdapter extends TypeAdapter<Hlc> {
  @override
  final int typeId;

  final String nodeId;

  HlcAdapter(this.typeId, this.nodeId);

  @override
  Hlc read(BinaryReader reader) => Hlc.fromLogicalTime(reader.read(), nodeId);

  @override
  void write(BinaryWriter writer, Hlc obj) => writer.write(obj.logicalTime);
}

class RecordAdapter<T> extends TypeAdapter<Record> {
  @override
  final typeId;

  RecordAdapter(this.typeId);

  @override
  Record read(BinaryReader reader) {
    final hlc = reader.read();
    final modified = reader.read();
    final value = reader.read();
    return Record<T>(hlc, value, modified);
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer.write(obj.hlc);
    writer.write(obj.modified);
    writer.write(obj.value);
  }
}
