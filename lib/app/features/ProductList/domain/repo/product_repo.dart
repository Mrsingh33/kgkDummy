import 'package:dartz/dartz.dart';
import 'package:kgk_test/app/core/http_helper/errors/failure.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';


abstract class ProductLoadRepository {
  Future<Either<Failure,  List<ProductListModel>>> productDataLoaded();
}