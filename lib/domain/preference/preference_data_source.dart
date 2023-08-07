import 'package:bloc_pattern_test_3/page/bloc/bloc.dart';

abstract class PreferenceDataSource {
  Future<int?> getCount();

  Future<void> setCount(int count);
}
