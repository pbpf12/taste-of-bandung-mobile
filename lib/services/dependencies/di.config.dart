// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/search/data/datasources/_datasources.dart' as _i485;
import '../../features/search/logic/_logic.dart' as _i909;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i485.SearchRemoteDataSource>(
        () => _i485.SearchRemoteDataSourcesImplementation());
    gh.factory<_i909.SearchCubit>(
        () => _i909.SearchCubit(gh<_i485.SearchRemoteDataSource>()));
    return this;
  }
}
