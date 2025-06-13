import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart'; // Para kDebugMode
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart'; // Certifique-se que GameModel está aqui

abstract class AbstractProductRepository {
  Future<List<ProductModel>> searchGames(String query, {int pageSize = 10});
  Future<ProductModel> getGameDetails(int gameId);
  Future<List<ProductModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering});
}

class ProductRepository implements AbstractProductRepository {
  final FirebaseFunctions _functions;

  ProductRepository({FirebaseFunctions? functions}) : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'southamerica-east1') {
    if (kDebugMode) {
      _functions.useFunctionsEmulator('localhost', 5001);
    }
  }

  Future<dynamic> _callFunction(String functionName, Map<String, dynamic> params) async {
    try {
      final callable = _functions.httpsCallable(functionName, options: HttpsCallableOptions(timeout: const Duration(seconds: 30)));
      final HttpsCallableResult result = await callable.call(params);
      return result.data;
    } on FirebaseFunctionsException catch (e) {
      throw Exception("Erro ao comunicar com o servidor: ${e.message ?? e.code}");
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado. Tente novamente mais tarde.");
    }
  }

  @override
  Future<List<ProductModel>> searchGames(String query, {int pageSize = 10}) async {
    final responseData = await _callFunction('searchRawgGames', {'query': query, 'pageSize': pageSize});

    if (responseData == null || responseData['results'] == null) {
      return [];
    }

    final List results = responseData['results'] as List;
    List<ProductModel> games = results.map((gameData) => ProductModel.fromJson(gameData as Map<String, dynamic>)).toList();

    return games;
  }

  @override
  Future<ProductModel> getGameDetails(int gameId) async {
    final responseData = await _callFunction('getRawgGameDetails', {'gameId': gameId});

    if (responseData == null) {
      throw Exception('Não foram encontrados detalhes para o jogo com ID $gameId.');
    }

    ProductModel gameDetails = ProductModel.fromJson(responseData as Map<String, dynamic>);

    return gameDetails;
  }

  @override
  Future<List<ProductModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering}) async {
    final responseData = await _callFunction('getRawgDiscoverGames', {'page': page, 'pageSize': pageSize, 'ordering': ordering ?? '-added'});

    if (responseData == null || responseData['results'] == null) {
      return [];
    }

    final List results = responseData['results'] as List;

    List<ProductModel> discoverGames = results.map((gameData) => ProductModel.fromJson(gameData as Map<String, dynamic>)).toList();
    return discoverGames;
  }
}
