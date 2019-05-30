import 'package:open_copyright_platform/products/products_state.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded({this.products}) : super([products]);

  ProductsLoaded copyWith({List<Product> products}) {
    return ProductsLoaded(products: products ?? this.products);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${products.length} }';
  }
}
