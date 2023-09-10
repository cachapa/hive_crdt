import 'package:crdt/crdt.dart';
import 'package:crdt/map_crdt.dart';
import 'package:hive/hive.dart';

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId;

  RecordAdapter(this.typeId);

  @override
  Record read(BinaryReader reader) {
    final value = reader.read();
    final isDeleted = reader.readBool();
    final hlc = reader.readString().toHlc;
    final modified = reader.readString().toHlc;
    return Record(value, isDeleted, hlc, modified);
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer.write(obj.value);
    writer.writeBool(obj.isDeleted);
    writer.writeString(obj.hlc.toString());
    writer.writeString(obj.modified.toString());
  }
}
