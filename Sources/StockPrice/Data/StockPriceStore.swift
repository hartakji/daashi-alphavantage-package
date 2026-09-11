//
//  StockPriceStore.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import Foundation

struct StockPriceStore {
    
    public enum Error: Swift.Error {
        case invalidUrl
        case invalidResponse
    }
    
    private let token: String
    
    public init(token: String) {
        self.token = token
    }
}

// https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=STOCK&interval=5min&apikey=API_KEY
extension StockPriceStore: StockPriceStoreProtocol {
    
    func getStockPrice(_ stock: String) async throws -> StockPrice {
        let urlString = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(stock)&interval=5min&apikey=\(token)"
        guard let url = URL(string: urlString) else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let stockPriceDTO = try decoder.decode(StockPriceDTO.self, from: data)
        guard let price = stockPriceDTO.globalQuote["05. price"], let priceDouble = Double(price) else {
            throw Error.invalidResponse
        }
        return StockPrice(value: priceDouble)
    }
}
