//
//  AlphavantageWidgetPackDescriptor.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import WidgetFoundation
import SwiftUI

public struct AlphavantageWidgetPackDescriptor: WidgetPackDescriptor {
    
    public static var packInfo: WidgetPackInfo {
        WidgetPackInfo(
            name: "Alphavantage",
            description: "Widgets to interface with www.alphavantage.co's API",
            image: Image("ic_widgetPack_av", bundle: .module)
        )
    }
    
    public static var widgets: [WidgetFoundation.Widget] {
        [
            Widget(
                identifier: StockPriceConfig.componentIdentifier,
                name: "Stock Price",
                description: "Display the current price of a stock",
                image: Image("ic_stock_price", bundle: .module),
                availableFormFactor: [.square],
                availableSize: [.small]
            )
        ]
    }

    public static func configType(
        for identifier: String
    ) -> WidgetFoundation.WidgetConfigPayload.Type {
        switch identifier {
        case StockPriceConfig.componentIdentifier:
            return StockPriceConfig.self
        default:
            break
        }
        fatalError("Unable to find config for \(identifier)")
    }
    
    @MainActor
    public static func makeView<T>(
        for identifier: String,
        config: T
    ) -> (AnyView, any WidgetEventHandlerProtocol) where T : WidgetConfigPayload {
        switch identifier {
            
        case StockPriceConfig.componentIdentifier:
            if let config = config as? StockPriceConfig {
                
                let viewModel = StockPriceViewModel()
                let eventHandler = StockPriceEventHandler(
                    config: config,
                    viewModel: viewModel,
                    interactor: StockPriceInteractor(
                        store: StockPriceStore(token: config.apiToken)
                    )
                )

                let view = StockPriceView(viewModel: viewModel, delegate: eventHandler)
                
                return (view: AnyView(view), eventHandler: eventHandler)
            }
        default:
            break
        }
        
        fatalError("Unable to make view for identifier: \(identifier)")
    }
    
    @MainActor
    public static func makeConfigurator(
        for identifier: String,
        config: (any WidgetConfigPayload)?,
        onSave: @escaping (any WidgetConfigPayload) -> Void
    ) -> AnyView {
        switch identifier {
            
        case StockPriceConfig.componentIdentifier:
            if let config = config as? StockPriceConfig? {
                let view = StockPriceConfiguratorView(
                    previousConfig: config,
                    onSave: { newConfig in
                        onSave(newConfig)
                    }
                )
                return AnyView(view)
            }
        default:
            break
        }
        
        fatalError("Unable to make configurator view for identifier: \(identifier)")
    }
}
