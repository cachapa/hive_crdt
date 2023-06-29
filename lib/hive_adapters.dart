import 'package:crdt/crdt.dart';
import 'package:hive/hive.dart';

class HlcAdapter<T> extends TypeAdapter<Hlc> {
  @override
  final int typeId;

  HlcAdapter(this.typeId);

  @override
  Hlc read(BinaryReader reader, [T Function(String value)? idDecoder]) =>
      Hlc<T>.parse(reader.read(), idDecoder);

  @override
  void write(BinaryWriter writer, Hlc obj) => writer.write(obj.toString());
}

class HlcCompatAdapter<T> extends TypeAdapter<Hlc> {
  @override
  final int typeId;
  final T nodeId;

  HlcCompatAdapter(this.typeId, this.nodeId);

  @override
  Hlc read(BinaryReader reader) =>
      Hlc<T>.fromLogicalTime(reader.read(), nodeId);

  @override
  void write(BinaryWriter writer, Hlc obj) => writer.write(obj.logicalTime);
}

class RecordAdapter<T> extends TypeAdapter<Record> {
  @override
  final int typeId;

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
