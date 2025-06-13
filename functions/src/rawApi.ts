import axios, { AxiosInstance } from "axios";
import { defineString } from "firebase-functions/params";
import * as logger from "firebase-functions/logger";
import { HttpsError } from "firebase-functions/v2/https";

const rawgApiKey = defineString("RAWG_APIKEY");

const apiClient: AxiosInstance = axios.create({
    baseURL: "https://api.rawg.io/api",
    params: {
        key: rawgApiKey.value(),
    },
});

export async function callRawgApi<T>(endpoint: string, params: Record<string, any> = {}, functionName: string): Promise<T> {
    try {
        logger.info(`Chamando API RAWG (${functionName}): endpoint=${endpoint}`, { params });
        const response = await apiClient.get<T>(endpoint, { params });
        return response.data;
    } catch (error: any) {
        const errorData = error.response?.data || error.message;
        logger.error(`Erro ao chamar API RAWG (${functionName}):`, errorData, { structuredData: true });
        throw new HttpsError("internal", `Falha na comunicação com a API de jogos.`, errorData);
    }
}