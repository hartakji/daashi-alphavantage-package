//
//  StockPriceView.swift
//  AlphavantageWidget
//
//  Created by Jean DAHER on 11/09/2026.
//

import SwiftUI

public struct StockPriceView: View {

    @ObservedObject
    public var viewModel: StockPriceViewModel
    private var delegate: StockPriceViewDelegate?

    public init(
        viewModel: StockPriceViewModel,
        delegate: StockPriceViewDelegate? = nil
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
    }

    public var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 3) {
                Text(viewModel.stockCode)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12))
                    .bold()
                    .multilineTextAlignment(.center)
                Text(viewModel.stockValue)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 25))
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity)
            VStack(spacing: 0) {
                Text(viewModel.lastUpdate)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 10))
                    .bold()
                    .multilineTextAlignment(.center)
            }.frame(maxHeight: 19)
        }
    }
}

import WidgetFoundation
#Preview {
    StockPriceView(
        viewModel: StockPriceViewModel(
            stockCode: "AMAT",
            stockValue: "250",
            lastUpdate: "10h55"
        )
    )
    .toWidget()
}
