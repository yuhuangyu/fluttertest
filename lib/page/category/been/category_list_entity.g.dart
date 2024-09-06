// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListEntity _$CategoryListEntityFromJson(Map<String, dynamic> json) =>
    CategoryListEntity(
      categoryList: (json['categoryList'] as List<dynamic>?)
          ?.map((e) => CategoryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryListEntityToJson(CategoryListEntity instance) =>
    <String, dynamic>{
      'categoryList': instance.categoryList,
    };

CategoryInfo _$CategoryListFromJson(Map<String, dynamic> json) => CategoryInfo(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CategoryListToJson(CategoryInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
