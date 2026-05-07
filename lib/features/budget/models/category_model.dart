class CategoryModel {
  CategoryModel({this.categoryId, required this.name, required this.iconCode});

  final int? categoryId;
  final String name;
  final int iconCode;

  static CategoryModel empty() =>
      CategoryModel(categoryId: null, name: '', iconCode: 0);

  // Function to convert into Sqflite input
  Map<String, dynamic> toMap() {
    return {'categoryId': categoryId, 'name': name, 'iconCode': iconCode};
  }

  // Function to convert from Sqflite output
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] as int?,
      name: map['name'] as String,
      iconCode: map['iconCode'] as int,
    );
  }
}
