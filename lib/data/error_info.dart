import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../core/utils/log_utils.dart';

class HttpException implements Exception {
  final int resCode;

  HttpException({required this.resCode});
}

class InvalidArgumentException extends Equatable implements Exception {
  final String msg;

  const InvalidArgumentException(this.msg);

  @override
  String toString() {
    return 'InvalidArgumentException{msg: $msg}';
  }

  @override
  List<Object?> get props => [msg];
}

class ErrorInfo extends Equatable {
  final Exception? exception;
  final Object? object;
  final String? message;

  int get httpCode {
    final exc = exception;
    if (exc is PlatformException) {
      final resCode = exc.code;
      if (resCode.contains("HTTP_")) {
        if (resCode.contains("HTTP_Optional")) {
          logger.d("[ios]optionalData income: ${resCode.replaceAll("HTTP_Optional(", "").replaceAll(")", "")}");
          return int.parse(resCode.replaceAll("HTTP_Optional(", "").replaceAll(")", ""));
        } else {
          return int.parse(resCode.replaceAll("HTTP_", ""));
        }
      } else {
        return 0;
      }
    } else if (exc is HttpException) {
      return exc.resCode;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> get detail {
    try {
      final jsonString = (exception as PlatformException?)?.details as String;
      return jsonDecode(jsonString);
    } on Exception catch (error, stacktrace) {
      logger.err(error, stacktrace);
      return {};
    }
  }

  const ErrorInfo({this.exception, this.object, this.message});

  factory ErrorInfo.simple(dynamic e) {
    if (e is Exception) {
      return ErrorInfo(exception: e);
    } else {
      return ErrorInfo(object: e);
    }
  }

  @override
  List<Object?> get props => [exception, object, message];

  String toMessage() {
    final ret = StringBuffer();
    if (message != null) {
      ret.writeln("message: $message");
    }

    if (httpCode != 0) {
      ret.writeln("statusCode: $httpCode");
    }

    if (exception != null) {
      ret.writeln("statusCode: ${exception.toString()}");
    }

    if (object != null) {
      ret.writeln("statusCode: ${object.runtimeType}, $object");
    }

    return ret.toString();
  }
}

Exception generateHttpException(int resCode) {
  return HttpException(resCode: resCode);
}
