// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 3;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as num,
      images: (fields[3] as List).cast<String>(),
      salePercentage: fields[4] as num?,
      salePrice: fields[5] as num?,
      desc: fields[6] as String,
      isFav: fields[7] as bool,
      brand: fields[8] as String,
      thumbnail: fields[9] as String,
      category: fields[10] as Category,
      rating: fields[11] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.salePercentage)
      ..writeByte(5)
      ..write(obj.salePrice)
      ..writeByte(6)
      ..write(obj.desc)
      ..writeByte(7)
      ..write(obj.isFav)
      ..writeByte(8)
      ..write(obj.brand)
      ..writeByte(9)
      ..write(obj.thumbnail)
      ..writeByte(10)
      ..write(obj.category)
      ..writeByte(11)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
