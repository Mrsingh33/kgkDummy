import 'package:dartz/dartz.dart';
import 'package:kgk_test/app/core/http_helper/errors/failure.dart';
import 'package:kgk_test/app/core/models/use_case_request_model.dart';
import 'package:kgk_test/app/core/use_cases/use_case.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';
import 'package:kgk_test/app/features/ProductList/domain/repo/product_repo.dart';

class ProductsLoadUseCase extends UseCase<Either<Failure,  List<ProductListModel>>,
    UseCaseRequestModel> {
  ProductLoadRepository productLoadRepository;
  ProductsLoadUseCase({required this.productLoadRepository});

  @override
  Future<Either<Failure, List<ProductListModel>>> call() {
    var response = productLoadRepository.productDataLoaded(

    );
    return response;
  }
}