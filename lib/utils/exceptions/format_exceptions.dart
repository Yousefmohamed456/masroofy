class AFormatException implements Exception {
  /// The default constructor
  AFormatException();

  /// Get the corresponding error message
  String get message {
    return 'Invalid data format. Failed to parse dates or numbers correctly. Your local data might be corrupted.';
  }
}