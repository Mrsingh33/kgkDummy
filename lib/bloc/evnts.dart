import 'package:kgk_test/product_list.dart';

import '../product_list_model.dart';

class ProductEvents {}

class ApiCallForProduct extends ProductEvents {

}
class ProductSelectionEvents extends ProductEvents {
final ProductListModel selectedProduct;
ProductSelectionEvents({required this.selectedProduct});
}

class ShowOnlySelectedProduct extends ProductEvents {
  final List<ProductListModel> selectedProductList;
  ShowOnlySelectedProduct({required this.selectedProductList});
}