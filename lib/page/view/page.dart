import 'package:bloc_pattern_test_3/domain/preference/preference_data_source.dart';
import 'package:bloc_pattern_test_3/domain/preference/preference_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/locator/service_locator.dart';
import '../../main.dart';
import '../counter.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // BlocProvider로 MaterialApp을 감싼다.
      create: (context) => CounterBloc(pref: PreferenceRepository()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
