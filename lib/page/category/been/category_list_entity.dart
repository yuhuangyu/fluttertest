import 'package:json_annotation/json_annotation.dart';

part 'category_list_entity.g.dart';

@JsonSerializable()
class CategoryListEntity {
  final List<CategoryInfo>? categoryList;

  const CategoryListEntity({
    this.categoryList,
  });

  factory CategoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListEntityToJson(this);
}

@JsonSerializable()
class CategoryInfo {
  final String? name;
  final String? code;

  const CategoryInfo({
    this.name,
    this.code,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}
