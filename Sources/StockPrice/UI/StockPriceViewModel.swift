//
//  StockPriceViewModel.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import Foundation

@MainActor
public class StockPriceViewModel: ObservableObject {
    
    @Published var stockCode: String
    @Published var stockValue: String
    @Published var lastUpdate: String
    
    init(
        stockCode: String = "N/A",
        stockValue: String = "N/A",
        lastUpdate: String = "Unknown"
    ) {
        self.stockCode = stockCode
        self.stockValue = stockValue
        self.lastUpdate = lastUpdate
    }
}
