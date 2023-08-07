import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern_test_3/page/bloc/bloc.dart';
import 'package:bloc_pattern_test_3/page/view/page.dart';

const BUILD_TYPE = String.fromEnvironment('BUILD_TYPE', defaultValue: "develop");

void main() {
  print('jusong main in main');
  runApp(const MyApp());
}
