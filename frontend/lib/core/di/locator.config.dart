// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;
import 'package:void_chat/core/di/modules.dart' as _i980;
import 'package:void_chat/core/l10n/cubit/l10n_cubit.dart' as _i331;
import 'package:void_chat/core/storage/app_prefs.dart' as _i643;
import 'package:void_chat/core/theme/cubit/theme_cubit.dart' as _i542;
import 'package:void_chat/router/app_router.dart' as _i724;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i207.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i724.AppRouter>(() => _i724.AppRouter());
    gh.lazySingleton<_i643.AppPrefs>(
      () => _i643.AppPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i331.L10nCubit>(() => _i331.L10nCubit(gh<_i643.AppPrefs>()));
    gh.factory<_i542.ThemeCubit>(() => _i542.ThemeCubit(gh<_i643.AppPrefs>()));
    return this;
  }
}

class _$RegisterModule extends _i980.RegisterModule {}
