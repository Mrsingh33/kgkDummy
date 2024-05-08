import 'package:dartz/dartz.dart';
import 'package:kgk_test/app/core/http_helper/errors/exception.dart';
import 'package:kgk_test/app/core/http_helper/errors/failure.dart';
import 'package:kgk_test/app/core/http_helper/models/request_model.dart';
import 'package:kgk_test/app/features/ProductList/data/data_sources/product_list_datasources.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';

import 'package:kgk_test/app/features/ProductList/domain/repo/product_repo.dart';

class ProductRepositoryImpl extends ProductLoadRepository {
  ProductDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<ProductListModel>>> productDataLoaded() async {
    try {
      final response = await productDataSource.getProducts();
      if (response.status == RequestStatus.SUCCESS) {
        return Right(
          response.body!,
        );
      } else {
        return Left(
          Error(response.message ?? response.message!),
        );
      }
    } on ServerException {
      return const Left(
        ServerFailure('An error has occurred'),
      );
    }
  }

}