import 'package:open_copyright_platform/products/products_state.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ProductShowLoaded extends ProductsState {
  final Product product;

  ProductShowLoaded({this.product}) : super([product]);

  ProductShowLoaded copyWith({Product product}) {
    return ProductShowLoaded(product: product ?? this.product);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${product.name} }';
  }
}
