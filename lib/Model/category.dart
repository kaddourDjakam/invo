class CategoryModel {
  String nameCategory;

  CategoryModel({
    this.nameCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      nameCategory: json["nameCategory"],
    );
  }
}
