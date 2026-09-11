//
//  StockPriceEventHandler.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import Foundation
import WidgetFoundation

@MainActor
class StockPriceEventHandler {
    
    var viewModel: StockPriceViewModel
    var interactor: StockPriceInteractorProtocol
    var config: StockPriceConfig
        
    required init(
        config: StockPriceConfig,
        viewModel: StockPriceViewModel,
        interactor: StockPriceInteractorProtocol
    ) {
        self.config = config
        self.viewModel = viewModel
        self.interactor = interactor
    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    @MainActor
    func setViewModel(_ stockPrice: StockPrice) {
        viewModel.stockCode = config.stockCode
        viewModel.stockValue = String(format: "%.2f", stockPrice.value)
        viewModel.lastUpdate = dateFormatter.string(from: .now)
    }
    
    @MainActor
    func performAsyncTask() async {
        Task { [weak self] in
            guard let self else { return }
            do {
                let stockPrice = try await interactor.getStockPrice(config.stockCode)
                setViewModel(stockPrice)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func startFifteenMinuteLoop() {
        Task {
            await performAsyncTask()
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(60*Double(config.refreshInterval)))
                guard !Task.isCancelled else { break }
                await performAsyncTask()
            }
        }
    }
}

extension StockPriceEventHandler: StockPriceViewDelegate {
    
}

extension StockPriceEventHandler: WidgetEventHandlerProtocol {
    
    func onLoad() {
        startFifteenMinuteLoop()
    }
    
    @MainActor
    func onUnload() {
        
    }
}
