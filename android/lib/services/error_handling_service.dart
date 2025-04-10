import 'package:flutter/material.dart';
import 'firebase_errors.dart';
import 'network_service.dart';

/// Interface for error handling service following Interface Segregation Principle
abstract class IErrorHandlingService {
  void handleError(dynamic error, {String? context});
  void showErrorSnackBar(BuildContext context, String message);
  void logError(dynamic error, {String? context, StackTrace? stackTrace});
  String getErrorMessage(dynamic error);
}

/// Implementation of error handling service following Single Responsibility Principle
class ErrorHandlingService implements IErrorHandlingService {
  final NetworkService _networkService;
  
  ErrorHandlingService(this._networkService);

  @override
  void handleError(dynamic error, {String? context}) {
    // Log the error
    logError(error, context: context);
    
    // Handle specific error types
    if (error is FirebaseNetworkException) {
      _handleNetworkError(error);
    } else if (error is FirebasePermissionException) {
      _handlePermissionError(error);
    } else if (error is FirebaseDataException) {
      _handleDataError(error);
    } else {
      _handleGenericError(error);
    }
  }

  @override
  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  void logError(dynamic error, {String? context, StackTrace? stackTrace}) {
    // In a real app, you would send this to a logging service
    print('Error in ${context ?? 'unknown context'}: $error');
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
  }

  @override
  String getErrorMessage(dynamic error) {
    if (error is FirebaseNetworkException) {
      return 'Network error: ${error.message}';
    } else if (error is FirebasePermissionException) {
      return 'Permission denied: ${error.message}';
    } else if (error is FirebaseDataException) {
      return 'Data error: ${error.message}';
    } else if (error is FirebaseServiceException) {
      return error.message;
    } else {
      return 'An unexpected error occurred: ${error.toString()}';
    }
  }

  void _handleNetworkError(FirebaseNetworkException error) async {
    // Handle network-specific errors
    if (!(await _networkService.isConnected)) {
      // Handle offline state
      print('Device is offline: ${error.message}');
    } else {
      // Handle other network errors
      print('Network error: ${error.message}');
    }
  }

  void _handlePermissionError(FirebasePermissionException error) {
    // Handle permission-specific errors
    print('Permission error: ${error.message}');
  }

  void _handleDataError(FirebaseDataException error) {
    // Handle data-specific errors
    print('Data error: ${error.message}');
  }

  void _handleGenericError(dynamic error) {
    // Handle generic errors
    print('Generic error: ${error.toString()}');
  }
}

/// Factory for creating error handling services
class ErrorHandlingServiceFactory {
  static IErrorHandlingService create(NetworkService networkService) {
    return ErrorHandlingService(networkService);
  }
} 