import 'package:auth_app1/core/utils/data_state.dart';

typedef ResultFuture<T> = Future<DataState<T>>;

typedef ResultWithoutFuture<T> = DataState<T>;

///
abstract class UsecaseWithParams<Type, Params> {
  UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  UsecaseWithoutParams();
  ResultFuture<Type> call();
}

abstract class UseCase<T> {
  Future<T> call();
}
