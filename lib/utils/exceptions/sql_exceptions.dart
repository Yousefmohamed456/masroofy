


class ASQLiteException implements Exception {
  final String error;

  ASQLiteException(this.error);

  String get message {
    if (error.contains('UNIQUE constraint failed')) {
      return 'This record already exists in the database.';
    }
    if (error.contains('FOREIGN KEY constraint failed')) {
      return 'Cannot perform action because related data is missing.';
    }
    if (error.contains('database is locked')) {
      return 'The database is currently busy. Please try again.';
    }
    if (error.contains('no such table')) {
      return 'Database structure error. Please restart the app.';
    }
    if (error.contains('readonly database')) {
      return 'Cannot save right now due to device storage restrictions.';
    }

    // Default fallback
    return 'A local database error occurred. Please try again.';
  }
}