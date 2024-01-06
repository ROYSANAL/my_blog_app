class Resource<T> {
  final T? data;
  final String? error;

  Resource({required this.data, required this.error});

  Resource<T2> transform<T2>(T2 Function(T) transformer) {
    if (this is Success<T>) {
      return Success(transformer(data!));
    } else {
      return Failure(error!);
    }
  }
}

class Success<T> extends Resource<T> {
  final T data;

  Success(this.data) : super(data: data, error: null);
}

class Failure<T> extends Resource<T> {
  final String error;

  Failure(this.error) : super(data: null, error: error);
}
