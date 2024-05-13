
import 'package:flutter/cupertino.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';

class ProductState {}

class IntialStateForProducts extends ProductState {}
class LoadingStateForProducts extends ProductState {

}
class ShowOnlySelectedStateForProducts extends ProductState {
  final List<ProductListModel> data;
  ShowOnlySelectedStateForProducts({required this.data});
}
class LoadedStateForProducts extends ProductState {
  final List<ProductListModel> data;
  LoadedStateForProducts({required this.data});
}
class ProductSelectedState extends ProductState {
  final ProductListModel selectedProduct;
  final int intValue;
  final int currentDataLength;
  ProductSelectedState({required this.selectedProduct,required this.intValue,required this.currentDataLength});
}
class ErrorStateForProducts extends ProductState {
  final String error;
  ErrorStateForProducts({required this.error});
}
class ScrollToProductState extends ProductState {
  final ScrollController controller;
  ScrollToProductState({required this.controller});
}
