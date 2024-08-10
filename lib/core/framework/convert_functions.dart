import 'package:renweather/core/core.dart';

Future<NotifierState<Response>> convert<Response>(
  MainFunction<Response> f, {
  Function(ServiceResponse<Response>)? then,
}) async {
  var response = await f();
  then?.call(response);
  return response.toNotifierState();
}

Future<NotifierState<Response>> convertWithArgument<Response, Argument>(
  MainFunctionWithArgument<Response, Argument> f,
  Argument argument, {
  Function(ServiceResponse<Response>)? then,
}) async {
  var response = await f(argument);
  then?.call(response);
  return response.toNotifierState();
}

typedef MainFunctionWithArgument<Response, Argument>
    = Future<ServiceResponse<Response>> Function(Argument argument);

typedef MainFunction<Response> = Future<ServiceResponse<Response>> Function();
