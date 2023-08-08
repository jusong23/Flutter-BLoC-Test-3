import 'preference_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_pattern_test_3/page/bloc/bloc.dart';

class PreferenceRepository extends PreferenceDataSource {
  static const _PREF_COUNT = "PREF_COUNT";

  @override
  Future<int?> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    int? result;
    result = prefs.getInt(_PREF_COUNT);
    print('jusong getCount()');
    return result;
  }

  @override
  Future<void> setCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_PREF_COUNT, count);
    print('jusong setCount()');
  }

}