class APlatformException implements Exception {
  final String code;

  APlatformException(this.code);

  String get message {
    switch (code) {
      case 'sqlite_error':
        return 'The device encountered an error reading the local database file.';
      case 'io_error':
        return 'Device storage error. Make sure your phone has enough free space.';
      default:
        return 'A platform error occurred: $code. Please check your device settings.';
    }
  }
}
