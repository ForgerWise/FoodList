import 'package:hive/hive.dart';

part 'sub_category.g.dart';

@HiveType(typeId: 1)
class SubCategory {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  SubCategory({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  static SubCategory fromNameWithMapCheck(
      String name, Map<String, List<SubCategory>> subCategoryMap) {
    String generatedId = name.replaceAll(' ', '_');

    bool idExists = subCategoryMap.values.any((subCategories) =>
        subCategories.any((subCategory) => subCategory.id == generatedId));

    if (idExists) {
      generatedId += '_${DateTime.now().millisecondsSinceEpoch}';
    }

    return SubCategory(id: generatedId, name: name);
  }

  SubCategory copyWithName(String newName) {
    return SubCategory(id: this.id, name: newName);
  }
}
