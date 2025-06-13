// Arquivo: lib/modules/eccomerce/product/controller/product_controller.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/repository/product-repository.dart';

part 'product_state.dart';

class ProductController extends Cubit<ProductState> {
  final AbstractProductRepository _productRepository;

  ProductController({required AbstractProductRepository productRepository}) : _productRepository = productRepository, super(ProductInitial());

  Future<void> fetchDiscoverProducts({int page = 1, int pageSize = 20, String? ordering}) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getDiscoverGames(page: page, pageSize: pageSize, ordering: ordering);
      emit(ProductsLoadSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> searchForProducts(String query, {int pageSize = 10}) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.searchGames(query, pageSize: pageSize);
      emit(ProductsLoadSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductLoading());
    try {
      final product = await _productRepository.getGameDetails(productId);
      emit(ProductDetailsLoadSuccess(product));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
