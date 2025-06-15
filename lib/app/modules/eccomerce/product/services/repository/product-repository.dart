import 'package:dio/dio.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

abstract class AbstractProductRepository {
  Future<List<ProductModel>> searchGames(String query, {int pageSize = 10});
  Future<ProductModel> getGameDetails(int gameId);
  Future<List<ProductModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering});
}

class ProductRepository implements AbstractProductRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.rawg.io/api', queryParameters: {'key': Utils.apiKey}));

  @override
  Future<List<ProductModel>> searchGames(String query, {int pageSize = 10}) async {
    try {
      final response = await _dio.get('/games', queryParameters: {'search': query, 'page_size': pageSize});

      if (response.data == null || response.data['results'] == null) {
        return [];
      }

      final List results = response.data['results'] as List;
      final games = results.map((gameData) => ProductModel.fromJson(gameData as Map<String, dynamic>)).toList();
      return games;
    } on DioException catch (e) {
      throw Exception("Erro ao buscar jogos: ${e.message}");
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado ao processar os dados.");
    }
  }

  @override
  Future<ProductModel> getGameDetails(int gameId) async {
    try {
      final response = await _dio.get('/games/$gameId');

      if (response.data == null) {
        throw Exception('Não foram encontrados detalhes para o jogo com ID $gameId.');
      }

      final gameDetails = ProductModel.fromJson(response.data as Map<String, dynamic>);
      return gameDetails;
    } on DioException catch (e) {
      throw Exception("Erro ao obter detalhes do jogo: ${e.message}");
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado ao processar os dados.");
    }
  }

  @override
  Future<List<ProductModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering}) async {
    try {
      final response = await _dio.get('/games', queryParameters: {'page': page, 'page_size': pageSize, 'ordering': ordering ?? '-added'});

      if (response.data == null || response.data['results'] == null) {
        return [];
      }

      final List results = response.data['results'] as List;
      final discoverGames = results.map((gameData) => ProductModel.fromJson(gameData as Map<String, dynamic>)).toList();
      return discoverGames;
    } on DioException catch (e) {
      throw Exception("Erro ao descobrir jogos: ${e.message}");
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado ao processar os dados.");
    }
  }
}
