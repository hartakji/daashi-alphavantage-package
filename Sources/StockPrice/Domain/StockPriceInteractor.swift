//
//  StockPriceInteractor.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

class StockPriceInteractor {
    
    private let store: StockPriceStoreProtocol
    
    init(store: StockPriceStoreProtocol) {
        self.store = store
    }
}

extension StockPriceInteractor: StockPriceInteractorProtocol {
    
    func getStockPrice(_ stock: String) async throws -> StockPrice {
        try await store.getStockPrice(stock)
    }
}
