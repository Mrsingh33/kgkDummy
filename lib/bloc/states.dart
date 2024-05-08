import 'package:kgk_test/product_list.dart';
import 'package:kgk_test/product_list_model.dart';

class ProductState {}

class IntialStateForProducts extends ProductState {}
class LoadingStateForProducts extends ProductState {
  final List<ProductListModel> data;
  LoadingStateForProducts({required this.data});
}
class ShowOnlySelectedStateForProducts extends ProductState {
  final List<ProductListModel> data;
  ShowOnlySelectedStateForProducts({required this.data});
}
class LoadedStateForProducts extends ProductState {

}
class ProductSelectedState extends ProductState {
  final ProductListModel selectedProduct;
  ProductSelectedState({required this.selectedProduct});
}
class ErrorStateForProducts extends ProductState {
  final String error;
  ErrorStateForProducts({required this.error});
}
