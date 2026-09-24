//
//  StockPriceConfiguratorView.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import SwiftUI

struct StockPriceConfiguratorView: View {
    
    @State private var config: StockPriceConfig
    public var onSave: ((StockPriceConfig) -> Void)
    
    init(
        previousConfig: StockPriceConfig? = nil,
        onSave: (@escaping (StockPriceConfig) -> Void)
    ) {
        self.onSave = onSave
        self.config = previousConfig ?? StockPriceConfig(
            apiToken: "",
            refreshInterval: 15,
            stockCode: ""
        )
    }
    
    public var body: some View {
        VStack {
            Form {
                Section(header: Text("General")) {
                    TextField("API Token", text: $config.apiToken)
                }
                Section(header: Text("Stock Code")) {
                    TextField("Stock Code", text: $config.stockCode)
                }
                Section(header: Text("Refresh frequency")) {
                    Slider(value: $config.refreshInterval, in: 15...180, step: 15)
                    HStack {
                        Spacer()
                        Text("Refresh every \(String(format: "%1.0f", config.refreshInterval)) min")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        onSave(config)
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview {
    StockPriceConfiguratorView(onSave: { config in
        print("config: \(config)")
    })
}
