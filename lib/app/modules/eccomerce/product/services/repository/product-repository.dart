// lib/repositories/rawg_game_repository.dart
import 'package:dio/dio.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart';

abstract class AbstractGameRepository {
  Future<List<GameModel>> searchGames(String query, {int pageSize = 10});
  Future<GameModel> getGameDetails(int gameId);
  Future<List<GameModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering});
}

class RawgGameRepository implements AbstractGameRepository {
  final Dio _dio;
  final String _apiKey = 'SUA_CHAVE_API_RAWG_AQUI';
  static const String _apiBaseUrl = 'https://api.rawg.io/api';

  RawgGameRepository({Dio? dioClient}) : _dio = dioClient ?? Dio() {
    if (dioClient == null) {
      _dio.options.baseUrl = _apiBaseUrl;
      _dio.options.connectTimeout = Duration(milliseconds: 7000);
      _dio.options.receiveTimeout = Duration(milliseconds: 7000);
      _dio.options.headers = {'Accept': 'application/json'};
    }
  }

  @override
  Future<List<GameModel>> searchGames(String query, {int pageSize = 10}) async {
    if (_apiKey == 'SUA_CHAVE_API_RAWG_AQUI' || _apiKey.isEmpty) {
      throw Exception('Chave da API RAWG não configurada no RawgGameRepository.');
    }
    try {
      final response = await _dio.get('/games', queryParameters: {'key': _apiKey, 'search': query, 'page_size': pageSize});
      final Map<String, dynamic> responseData = response.data;
      final List results = responseData['results'] as List? ?? [];
      if (results.isEmpty) return [];
      return results.map((gameJson) => GameModel.fromJson(gameJson as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      String errorMessage = e.message ?? 'Falha ao buscar jogos na API RAWG.';
      if (e.response?.data != null && e.response!.data is Map) {
        final responseMap = e.response!.data as Map;
        errorMessage = responseMap['detail']?.toString() ?? responseMap['error']?.toString() ?? errorMessage;
      }
      print('DioException em searchGames (status ${e.response?.statusCode}): $errorMessage');
      throw Exception('Erro ao buscar jogos: $errorMessage');
    } catch (e) {
      print('Erro desconhecido em searchGames: $e');
      throw Exception('Ocorreu um erro inesperado ao buscar jogos.');
    }
  }

  @override
  Future<GameModel> getGameDetails(int gameId) async {
    if (_apiKey == 'SUA_CHAVE_API_RAWG_AQUI' || _apiKey.isEmpty) {
      throw Exception('Chave da API RAWG não configurada no RawgGameRepository.');
    }
    try {
      final response = await _dio.get('/games/$gameId', queryParameters: {'key': _apiKey});
      return GameModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      String errorMessage = e.message ?? 'Falha ao buscar detalhes do jogo ID $gameId.';
      if (e.response?.data != null && e.response!.data is Map) {
        final responseMap = e.response!.data as Map;
        errorMessage = responseMap['detail']?.toString() ?? responseMap['error']?.toString() ?? errorMessage;
      }
      print('DioException em getGameDetails (status ${e.response?.statusCode}): $errorMessage');
      throw Exception('Erro ao buscar detalhes do jogo: $errorMessage');
    } catch (e) {
      print('Erro desconhecido em getGameDetails: $e');
      throw Exception('Ocorreu um erro inesperado ao buscar detalhes do jogo.');
    }
  }

  @override
  Future<List<GameModel>> getDiscoverGames({int page = 1, int pageSize = 20, String? ordering}) async {
    if (_apiKey == 'SUA_CHAVE_API_RAWG_AQUI' || _apiKey.isEmpty) {
      throw Exception('Chave da API RAWG não configurada no RawgGameRepository.');
    }
    try {
      final String effectiveOrdering = ordering ?? '-added';

      final response = await _dio.get('/games', queryParameters: {'key': _apiKey, 'page': page, 'page_size': pageSize, 'ordering': effectiveOrdering});

      final Map<String, dynamic> responseData = response.data;
      final List results = responseData['results'] as List? ?? [];

      if (results.isEmpty) {
        return [];
      }

      final List<GameModel> games = results.map((gameJson) => GameModel.fromJson(gameJson as Map<String, dynamic>)).toList();

      print('RawgGameRepository: ${games.length} jogos descobertos (ordenação: $effectiveOrdering).');
      return games;
    } on DioException catch (e) {
      String errorMessage = e.message ?? 'Falha ao buscar lista de jogos na API RAWG.';
      if (e.response?.data != null && e.response!.data is Map) {
        final responseMap = e.response!.data as Map;
        errorMessage = responseMap['detail']?.toString() ?? responseMap['error']?.toString() ?? errorMessage;
      }
      print('DioException em getDiscoverGames (status ${e.response?.statusCode}): $errorMessage');
      throw Exception('Erro ao buscar jogos para descoberta: $errorMessage');
    } catch (e) {
      print('Erro desconhecido em getDiscoverGames: $e');
      throw Exception('Ocorreu um erro inesperado ao buscar jogos para descoberta.');
    }
  }
}
