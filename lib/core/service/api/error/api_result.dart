import 'error_model.dart';

sealed class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorModel error) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return failure((this as Failure<T>).errorModel);
    }
    throw Exception("Unhandled case in ApiResult.when");
  }

  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
    required R Function() orElse,
  }) {
    if (this is Success<T> && success != null) {
      return success((this as Success<T>).data);
    } else if (this is Failure<T> && failure != null) {
      return failure((this as Failure<T>).errorModel);
    }
    return orElse();
  }
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final ErrorModel errorModel;
  const Failure(this.errorModel);
}
