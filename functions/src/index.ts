import { onCall, HttpsError } from "firebase-functions/v2/https";
import { defineString } from "firebase-functions/params";
import axios from "axios";
import * as logger from "firebase-functions/logger";


const rawgApiKey = defineString("RAWG_APIKEY");

const RAWG_BASE_URL = "https://api.rawg.io/api";

export const getRawgGameDetails = onCall(async (request) => {
  const gameId = request.data.gameId as number;
  const apiKey = rawgApiKey.value();

  if (!gameId || typeof gameId !== 'number') {
    logger.error("Argumento 'gameId' inválido ou ausente:", request.data);
    throw new HttpsError("invalid-argument", "O parâmetro 'gameId' (numérico) é obrigatório.");
  }

  try {
    logger.info(`Buscando detalhes para gameId: ${gameId}`);
    const response = await axios.get(`${RAWG_BASE_URL}/games/${gameId}`, {
      params: { key: apiKey },
    });
    return response.data;
  } catch (error: any) {
    logger.error(`Erro ao chamar API RAWG (getGameDetails para gameId ${gameId}):`, error.response?.data || error.message, { structuredData: true });
    throw new HttpsError("internal", `Falha ao buscar detalhes do jogo ${gameId}.`, error.response?.data);
  }
});

export const searchRawgGames = onCall(async (request) => {
  const query = request.data.query as string;
  const pageSize = (request.data.pageSize as number | undefined) || 10;
  const page = (request.data.page as number | undefined) || 1;
  const apiKey = rawgApiKey.value();

  if (!query) {
    logger.error("Argumento 'query' ausente em searchRawgGames:", request.data);
    throw new HttpsError("invalid-argument", "O parâmetro 'query' é obrigatório.");
  }

  try {
    logger.info(`Buscando jogos com query: ${query}, page: ${page}, pageSize: ${pageSize}`);
    const response = await axios.get(`${RAWG_BASE_URL}/games`, {
      params: { key: apiKey, search: query, page_size: pageSize, page: page },
    });
    return response.data;
  } catch (error: any) {
    logger.error("Erro ao chamar API RAWG (searchRawgGames):", error.response?.data || error.message, { structuredData: true });
    throw new HttpsError("internal", "Falha ao buscar jogos.", error.response?.data);
  }
});

export const getRawgDiscoverGames = onCall(async (request) => {
  const pageSize = (request.data.pageSize as number | undefined) || 20;
  const page = (request.data.page as number | undefined) || 1;
  const ordering = (request.data.ordering as string | undefined) || "-added";
  const apiKey = rawgApiKey.value();

  try {
    logger.info(`Buscando jogos para descoberta: page: ${page}, pageSize: ${pageSize}, ordering: ${ordering}`);
    const response = await axios.get(`${RAWG_BASE_URL}/games`, {
      params: { key: apiKey, page_size: pageSize, page: page, ordering: ordering },
    });
    return response.data;
  } catch (error: any) {
    logger.error("Erro ao chamar API RAWG (getRawgDiscoverGames):", error.response?.data || error.message, { structuredData: true });
    throw new HttpsError("internal", "Falha ao buscar jogos para descoberta.", error.response?.data);
  }
});