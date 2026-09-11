//
//  StockPriceConfig.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import WidgetFoundation

public struct StockPriceConfig: WidgetConfigPayload {
    public static let componentIdentifier = "daashi.alphavantage.stock-price"
    
    var apiToken: String
    var refreshInterval: Float
    var stockCode: String
}
