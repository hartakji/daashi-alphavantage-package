# AlphavantageWidget

A Swift package that provides a [Daashi Widget Foundation](https://github.com/hartakji/daashi-widget-foundation) widget pack for interacting with [Alphavantage](https://www.alphavantage.co)'s REST API. It exposes ready-to-use dashboard widgets built on top of stock market data.

## Requirements

- iOS 16.0+
- Swift 5.7+
- A [`daashi-widget-foundation`](https://github.com/hartakji/daashi-widget-foundation) host application

## Installation

Add the package as a dependency via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/hartakji/daashi-alphavantage-package", from: "1.0.0")
]
```

## Widget Pack

The package registers itself with the Widget Foundation via `AlphavantageWidgetPackDescriptor`, which declares the pack's metadata (name, description, icon) and the list of widgets it provides.

### Stock Price

Displays the current price of a stock, along with the time it was last refreshed.

- **Identifier**: `daashi.alphavantage.stock-price`
- **Available form factor**: square
- **Available size**: small

#### Configuration

The widget is configured with an Alphavantage API token, a stock code, and a refresh interval:

```swift
public struct StockPriceConfig: WidgetConfigPayload {
    var apiToken: String
    var refreshInterval: Float // in minutes, 15...180
    var stockCode: String      // e.g. "AMAT"
}
```

A SwiftUI configuration form (`StockPriceConfiguratorView`) is provided out of the box for entering the API token, stock code, and refresh frequency.

#### How it works

The widget fetches data from Alphavantage's `GLOBAL_QUOTE` endpoint using the configured API token, and refreshes automatically on the configured interval:

1. **Data** (`StockPriceStore`) — calls the Alphavantage REST API and decodes the response into a `StockPriceDTO`.
2. **Domain** (`StockPriceInteractor`) — exposes the current stock price to the UI layer.
3. **UI** (`StockPriceView`, `StockPriceViewModel`, `StockPriceEventHandler`) — renders the widget and periodically refreshes it via the event handler's refresh loop.

## Architecture

Each widget in this package follows a layered structure:

```
Sources/StockPrice/
├── Data/       # Network/DTO layer (Store)
├── Domain/     # Business logic (Interactor, domain model, protocols)
└── UI/         # SwiftUI views, view models, config, and event handling
```

## License

See the repository for license details.
