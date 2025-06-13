part of 'product_controller.dart'; 

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoadSuccess extends ProductState {
  final List<ProductModel> products;

  const ProductsLoadSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductDetailsLoadSuccess extends ProductState {
  final ProductModel product;

  const ProductDetailsLoadSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductFailure extends ProductState {
  final String error;

  const ProductFailure(this.error);

  @override
  List<Object> get props => [error];
}