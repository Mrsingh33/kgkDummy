import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_test/bloc/states.dart';
import 'package:http/http.dart' as http;
import 'package:kgk_test/product_list_model.dart';
import 'evnts.dart';

class ProductBloc extends Bloc<ProductEvents,ProductState> {
  ProductBloc():super(IntialStateForProducts()){
    on<ApiCallForProduct>(getProductData);
    on<ProductSelectionEvents>(onProductSelection);
    on<ShowOnlySelectedProduct>(onSelectedOnly);
  }



}

Future<void> getProductData(event,emit) async {
  emit(LoadedStateForProducts());
  final response = await  http.get(Uri.parse("https://fakestoreapi.com/products"));
  if(response.statusCode == 200){
    final data = productListModelFromJson(response.body);
    emit(LoadingStateForProducts(data :data));
  }else{
    emit(ErrorStateForProducts(error : "Something went wrong"));
  }


}

void onProductSelection(event,emit) {
  emit(LoadedStateForProducts());
  emit(ProductSelectedState(selectedProduct: event.selectedProduct));

}
void onSelectedOnly(event,emit) {
  emit(LoadedStateForProducts());
  emit(ShowOnlySelectedStateForProducts(data: event.selectedProductList));

}