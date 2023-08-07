import 'package:get_it/get_it.dart';
import '../../domain/preference/preference_data_source.dart';
import '../../domain/preference/preference_repository.dart';

GetIt locator = GetIt.instance;

void _setupLocatorRepository() {
  locator.registerSingleton<PreferenceDataSource>(PreferenceRepository());
}

