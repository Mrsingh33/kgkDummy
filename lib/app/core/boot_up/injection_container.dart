import 'package:get_it/get_it.dart';
import 'package:kgk_test/app/features/ProductList/data/data_sources/product_list_datasources.dart';
import 'package:kgk_test/app/features/ProductList/domain/repo/product_repo.dart';
import 'package:kgk_test/app/features/ProductList/domain/use_cases/product_list_use_cases.dart';
import 'package:kgk_test/app/features/ProductList/presentation/bloc/bloc.dart';

import '../../features/ProductList/data/repos/product_repo_impl.dart';



final serviceLocator = GetIt.instance;

void setUpLocator() {
  ///Bloc
  serviceLocator.registerFactory(
        () =>
        ProductBloc(
          productsLoadUseCase: serviceLocator(),
        ),
  );


  ///UseCase
  serviceLocator.registerLazySingleton(
        () =>
        ProductsLoadUseCase(
         productLoadRepository: serviceLocator(),
        ),
  );

  ///Repository
  serviceLocator.registerLazySingleton<ProductLoadRepository>(
        () =>
            ProductRepositoryImpl(
        productDataSource: serviceLocator(),
        ),
  );

  ///DataSource
  serviceLocator.registerLazySingleton<ProductDataSource>(
        () =>
            HomeDataSourceImpl(

        ),
  );
}