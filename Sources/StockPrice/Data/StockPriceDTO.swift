//
//  StockPriceDTO.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

struct StockPriceDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
    
    let globalQuote: [String: String]
}
