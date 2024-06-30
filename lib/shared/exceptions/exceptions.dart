class BaseException implements Exception {
  String? message;

  BaseException({this.message}) {
    message ??= "Unknown Error Occurred";
  }

  void _logError(String message) {
    print("##################ERROR LOG##################");
    print(message);
    print("##################END##################");
  }
}

class AuthException extends BaseException {
  final String code;

  AuthException(this.code, {super.message}) {
    message = _getMessageFromErrorCode();
    super._logError(message!);
  }

  String _getMessageFromErrorCode() {
    if (code.contains("account-exists-with-different-credential")) {
      return "Account already exists with a different credential.";
    } else if (code.contains("email-already-in-use")) {
      return "Email already used. Go to login page.";
    } else if (code.contains("wrong-password")) {
      return "Wrong email or password.";
    } else if (code.contains("user-not-found")) {
      return "No user found with this email.";
    } else if (code.contains("user-disabled")) {
      return "User disabled.";
    } else if (code.contains("operation-not-allowed")) {
      return "Server error, please try again later.";
    } else if (code.contains("invalid-email")) {
      return "Email address is invalid.";
    } else {
      return "Error occurred. Please try again.";
    }
  }
}

class GoogleAuthException extends BaseException {
  GoogleAuthException({super.message}) {
    message = "Exception occurred while trying to use Google Sign In.";
    super._logError(message!);
  }
}

class FacebookAuthException extends BaseException {
  FacebookAuthException({super.message}) {
    message = "Exception occurred while trying to use Facebook Sign In.";
    super._logError(message!);
  }
}