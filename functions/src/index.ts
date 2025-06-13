import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { callRawgApi } from "./rawgApi";

export const getRawgGameDetails = onCall(async (request) => {
  const gameId = request.data.gameId as number;

  if (!gameId || typeof gameId !== 'number') {
    logger.error("Argumento 'gameId' inválido ou ausente:", request.data);
    throw new HttpsError("invalid-argument", "O parâmetro 'gameId' (numérico) é obrigatório.");
  }

  return callRawgApi(`/games/${gameId}`, {}, "getRawgGameDetails");
});

export const searchRawgGames = onCall(async (request) => {
  const query = request.data.query as string;
  const pageSize = (request.data.pageSize as number | undefined) || 10;
  const page = (request.data.page as number | undefined) || 1;

  if (!query) {
    logger.error("Argumento 'query' ausente em searchRawgGames:", request.data);
    throw new HttpsError("invalid-argument", "O parâmetro 'query' é obrigatório.");
  }

  const params = {
    search: query,
    page_size: pageSize,
    page: page,
  };
  
  return callRawgApi("/games", params, "searchRawgGames");
});

export const getRawgDiscoverGames = onCall(async (request) => {
  const pageSize = (request.data.pageSize as number | undefined) || 20;
  const page = (request.data.page as number | undefined) || 1;
  const ordering = (request.data.ordering as string | undefined) || "-added";

  const params = {
    page_size: pageSize,
    page: page,
    ordering: ordering,
  };
  
  return callRawgApi("/games", params, "getRawgDiscoverGames");
});