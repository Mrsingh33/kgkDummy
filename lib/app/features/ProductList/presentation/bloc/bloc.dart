

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_test/app/features/ProductList/domain/use_cases/product_list_use_cases.dart';


import 'package:kgk_test/app/features/ProductList/presentation/bloc/evnts.dart';
import 'package:kgk_test/app/features/ProductList/presentation/bloc/states.dart';



class ProductBloc extends Bloc<ProductEvents,ProductState> {
  ProductsLoadUseCase productsLoadUseCase;
  ProductBloc({required this.productsLoadUseCase}):super(IntialStateForProducts()){
    on<ApiCallForProduct>(getProductData);
    on<ProductSelectionEvents>(onProductSelection);
    on<ShowOnlySelectedProduct>(onSelectedOnly);

  }

  Future<void> getProductData(event,emit) async {
    emit(LoadingStateForProducts());


    final data = await productsLoadUseCase.call();
    data.fold((l) =>   emit(ErrorStateForProducts(error : l.message)), (r) => emit(LoadedStateForProducts(data: r)));





}

void onProductSelection(event,emit) {

  emit(LoadingStateForProducts());

  emit(ProductSelectedState(selectedProduct: event.selectedProduct, intValue: event.intValue, currentDataLength: event.currentDataLength));

}
void onSelectedOnly(event,emit) {
  emit(LoadingStateForProducts());
  emit(ShowOnlySelectedStateForProducts(data: event.selectedProductList));

}


}

