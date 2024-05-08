import 'package:equatable/equatable.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';

class ProductsEntity extends Equatable {
  final List<ProductListModel> productList;

  const ProductsEntity( {required this.productList});

  @override
  List<Object?> get props => [productList];
}