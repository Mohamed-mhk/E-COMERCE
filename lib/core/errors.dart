class NetworkExceptions {
  static String getErrorMessage(dynamic error) {
    // Map Dio error / HTTP codes to readable messages
    // Include AI validation errors here too
    return error.toString();
  }
}

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
