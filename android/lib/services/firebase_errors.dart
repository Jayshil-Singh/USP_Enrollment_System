/// Base exception class for Firebase-related errors
class FirebaseServiceException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  FirebaseServiceException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'FirebaseServiceException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Exception thrown when network-related errors occur
class FirebaseNetworkException extends FirebaseServiceException {
  final String path;

  FirebaseNetworkException(String message, {required this.path})
      : super(message, code: 'network_error');

  @override
  String toString() => 'FirebaseNetworkException: $message (Path: $path)';
}

/// Exception thrown when permission-related errors occur
class FirebasePermissionException extends FirebaseServiceException {
  final String path;

  FirebasePermissionException(String message, {required this.path})
      : super(message, code: 'permission_denied');

  @override
  String toString() => 'FirebasePermissionException: $message (Path: $path)';
}

/// Exception thrown when data-related errors occur
class FirebaseDataException extends FirebaseServiceException {
  final String path;
  final String operation;

  FirebaseDataException(
    String message, {
    required this.path,
    required this.operation,
  }) : super(message, code: 'data_error');

  @override
  String toString() =>
      'FirebaseDataException: $message (Path: $path, Operation: $operation)';
}

/// Utility class for handling Firebase exceptions
class FirebaseErrorHandler {
  static FirebaseServiceException handleFirebaseException(
    dynamic error, {
    required String path,
    required String operation,
  }) {
    if (error.toString().contains('permission-denied')) {
      return FirebasePermissionException(
        'Access denied to $path',
        path: path,
      );
    } else if (error.toString().contains('network-error')) {
      return FirebaseNetworkException(
        'Network error while accessing $path',
        path: path,
      );
    } else {
      return FirebaseDataException(
        error.toString(),
        path: path,
        operation: operation,
      );
    }
  }
} 