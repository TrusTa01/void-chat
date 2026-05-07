// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:backend/app_module.dart' as _i974;
import 'package:backend/core/di/modules.dart' as _i837;
import 'package:backend/src/api/auth_api.dart' as _i731;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shelf_router/shelf_router.dart' as _i278;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i278.Router>(() => registerModule.router);
    gh.lazySingleton<_i993.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i731.AuthApi>(() => _i731.AuthApi());
    gh.lazySingleton<_i974.AppModule>(
      () => _i974.AppModule(gh<_i278.Router>(), gh<_i731.AuthApi>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i837.RegisterModule {}
