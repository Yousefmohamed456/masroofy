import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masroofy/features/budget/models/category_model.dart';
import 'package:masroofy/utils/exceptions/format_exceptions.dart';
import 'package:masroofy/utils/exceptions/platform_exceptions.dart';
import 'package:masroofy/utils/exceptions/sql_exceptions.dart';
import 'package:masroofy/utils/exceptions/type_exceptions.dart';
import 'package:masroofy/utils/sqflite/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository extends GetxService {
  static CategoryRepository get instance => Get.find();
  final DatabaseHelper _db = DatabaseHelper.instance;

  /// Fetch all categories to display in the New Expense Grid
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final sql = 'SELECT * FROM categories ORDER BY categoryId ASC';
      final result = await _db.executeQuery(sql);
      return result.map((map) => CategoryModel.fromMap(map)).toList();
    } on DatabaseException catch (e) {
      throw ASQLiteException(e.toString()).message;
    } on TypeError catch (_) {
      // Handles casting errors (e.g. int vs double) inside fromMap
      throw ATypeError().message;
    } on FormatException catch (_) {
      // Handles DateTime parsing errors inside fromMap
      throw AFormatException().message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the categories.';
    }
  }

  /// Save a custom category created by the user
  Future<void> saveCategory(CategoryModel category) async {
    try {
      await _db.insertSql('categories', category.toMap());
    } on DatabaseException catch (e) {
      throw ASQLiteException(e.toString()).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Could not save category. Name might already exist.';
    }
  }
}
