import 'package:equatable/equatable.dart';

class CustomerError extends Equatable {
  final String code;
  final String message;
  final String plugin;
  const CustomerError({
    required this.code,
    required this.message,
    required this.plugin,
  });
  

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() => 'CustomerError(code: $code, message: $message, plugin: $plugin)';
}
