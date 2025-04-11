

import 'package:auth_app1/core/error/failure.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? error;

  const DataState({this.data, this.error});
}
//Success State
class DataSuccess<T> extends DataState<T> {
  const DataSuccess( T data) : super(data: data);
}

//Failure State
class DataFailed<T> extends DataState<T> {
    DataFailed (Failure error) :  super(error :  error);
}