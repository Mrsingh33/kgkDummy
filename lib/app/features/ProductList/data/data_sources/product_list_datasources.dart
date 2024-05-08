import 'package:kgk_test/app/core/http_helper/models/request_model.dart';
import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';
import 'package:http/http.dart' as http;
abstract class ProductDataSource {
  Future<RequestStatus<List<ProductListModel>>> getProducts();
}

class HomeDataSourceImpl extends ProductDataSource {


  HomeDataSourceImpl();

  @override
  Future<RequestStatus<List<ProductListModel>>> getProducts() async {
    try {


      final response = await  http.get(Uri.parse("https://fakestoreapi.com/products"));


      if (response.statusCode == 200) {
        final res = productListModelFromJson(response.body);
        return RequestStatus<List<ProductListModel>>(
          RequestStatus.SUCCESS,
          null,
          res,
        );
      } else {
        return RequestStatus<List<ProductListModel>>(
          RequestStatus.FAILURE,
          "Api Call failed",
          null,
        );
      }
    } catch (e) {

      return RequestStatus<List<ProductListModel>>(
        RequestStatus.FAILURE,
        "Something Went Wrong",
        null,
      );
    }
  }
}