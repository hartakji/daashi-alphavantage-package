//
//  StockPriceInteractorProtocol.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

protocol StockPriceInteractorProtocol {
    func getStockPrice(_ stock: String) async throws -> StockPrice
}
