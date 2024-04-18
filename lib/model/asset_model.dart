// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssetModel {
  int? id;
  String title;
  String description;
  bool isAvailable;
  String serialNumber;
  String assetType;
  String otherInfo;
  AssetModel({
    this.id,
    required this.title,
    required this.description,
    required this.isAvailable,
    required this.serialNumber,
    required this.assetType,
    required this.otherInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isAvailable': isAvailable ? 1 : 0,
      'serialNumber': serialNumber,
      'assetType': assetType,
      'otherInfo': otherInfo,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      isAvailable: map['isAvailable'] == 1,
      serialNumber: map['serialNumber'] as String,
      assetType: map['assetType'] as String,
      otherInfo: map['otherInfo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetModel.fromJson(String source) =>
      AssetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AssetModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isAvailable,
    String? serialNumber,
    String? assetType,
    String? otherInfo,
  }) {
    return AssetModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      serialNumber: serialNumber ?? this.serialNumber,
      assetType: assetType ?? this.assetType,
      otherInfo: otherInfo ?? this.otherInfo,
    );
  }

  @override
  String toString() {
    return 'AssetModel(id: $id, title: $title, description: $description, isAvailable: $isAvailable, serialNumber: $serialNumber, assetType: $assetType, otherInfo: $otherInfo)';
  }

  @override
  bool operator ==(covariant AssetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isAvailable == isAvailable &&
        other.serialNumber == serialNumber &&
        other.assetType == assetType &&
        other.otherInfo == otherInfo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isAvailable.hashCode ^
        serialNumber.hashCode ^
        assetType.hashCode ^
        otherInfo.hashCode;
  }
}
