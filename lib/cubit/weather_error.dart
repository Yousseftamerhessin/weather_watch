import 'package:equatable/equatable.dart';

class WeatherError extends Equatable {
  final String message;

  WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
