import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masroofy/features/budget/models/budget_cycle_model.dart';
import 'package:masroofy/utils/exceptions/format_exceptions.dart';
import 'package:masroofy/utils/exceptions/platform_exceptions.dart';
import 'package:masroofy/utils/exceptions/sql_exceptions.dart';
import 'package:masroofy/utils/exceptions/type_exceptions.dart';
import 'package:masroofy/utils/sqflite/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BudgetCycleRepository extends GetxService {
  static BudgetCycleRepository get instance => Get.find();
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> saveCycle(BudgetCycleModel cycle) async {
    try {
      await _db.insertSql('budget_cycles', cycle.toMap());
    } on DatabaseException catch (e) {
      throw ASQLiteException(e.toString()).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving the cycle.';
    }
  }

  Future<BudgetCycleModel?> getActiveCycle() async {
    try {
      final now = DateTime.now().toIso8601String();

      final sql = '''
    SELECT * 
    FROM budget_cycles 
    WHERE ?>= startDate AND ? <= endDate
    ORDER BY endDate DESC
    LIMIT 1
    ''';

      final result = await _db.executeQuery(sql, [now, now]);
      if (result.isEmpty) {
        return null;
      }

      return BudgetCycleModel.fromMap(result.first);
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
      throw 'Something went wrong while fetching the active cycle.';
    }
  }

  Future<List<BudgetCycleModel>> getAllCycles() async {
    try {
      final sql = '''
    SELECT * 
    FROM budget_cycles 
    ORDER BY endDate DESC
    ''';

      final result = await _db.executeQuery(sql);

      return result.map((cycle) => BudgetCycleModel.fromMap(cycle)).toList();
    } on DatabaseException catch (e) {
      throw ASQLiteException(e.toString()).message;
    } on TypeError catch (_) {
      // Handles casting errors inside fromMap
      throw ATypeError().message;
    } on FormatException catch (_) {
      // Handles DateTime parsing errors inside fromMap
      throw AFormatException().message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the active cycle.';
    }
  }
}
