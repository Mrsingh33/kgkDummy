import 'package:kgk_test/app/features/ProductList/presentation/pages/product_list.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';



class ProductEvents {}

class ApiCallForProduct extends ProductEvents {

}
class ProductSelectionEvents extends ProductEvents {
final ProductListModel selectedProduct;
final int intValue;
final int currentDataLength;
ProductSelectionEvents({required this.selectedProduct,required this.intValue,required this.currentDataLength});
}

class ShowOnlySelectedProduct extends ProductEvents {
  final List<ProductListModel> selectedProductList;
  ShowOnlySelectedProduct({required this.selectedProductList});
}

class ScrollToProductEvent extends ProductEvents {
final int index;
final int currentLength;
ScrollToProductEvent({required this.index,required this.currentLength});
}