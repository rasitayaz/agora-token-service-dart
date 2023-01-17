import 'dart:typed_data';

class ByteBuf {
  ByteBuf() {
    buffer.fillRange(0, buffer.length, 0);
  }

  final buffer = Uint8List(1024);
  int position = 0;

  Uint8List pack() {
    final out = Uint8List(position);
    out.setAll(0, buffer.sublist(0, position));
    return out;
  }

  ByteBuf putUint16(int v) {
    final bytes = ByteData(2);
    bytes.setUint16(0, v, Endian.little);
    buffer.setAll(position, bytes.buffer.asUint8List());
    position += 2;
    return this;
  }

  ByteBuf putUint32(int v) {
    final bytes = ByteData(4);
    bytes.setUint32(0, v, Endian.little);
    buffer.setAll(position, bytes.buffer.asUint8List());
    position += 4;
    return this;
  }

  ByteBuf putBytes(Uint8List bytes) {
    putUint16(bytes.length);
    buffer.setAll(position, bytes);
    position += bytes.length;
    return this;
  }

  ByteBuf putUint32Map(Map<int, int> map) {
    putUint16(map.length);
    map.forEach((key, value) {
      putUint16(key);
      putUint32(value);
    });
    return this;
  }
}
