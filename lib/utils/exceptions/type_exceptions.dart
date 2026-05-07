class ATypeError implements Exception {
  ATypeError();

  String get message {
    return 'Data format mismatch. The database returned an unexpected data type. Please contact support if this persists.';
  }
}
