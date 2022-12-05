//
//  DetailView.swift
//  USEconomicIndicators
//
//  Created by Shigenari Oshio on 2022/12/03.
//

import SwiftUI
import Charts

struct DetailView: View {
    let indicator: Indicator

    @State private var items: [Item] = []
    @State private var isLoading = false
    @State private var activeItem: Item = .init()
    @State private var selectedPeriod: Period = .all
    @State private var itemCountToDisplay = 0
    @State private var didError = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading { ProgressView() }
            else {
                Text(indicator.name(isEn: true)).foregroundStyle(.secondary)
                periodPicker
                activeItemValue
                lineChart(items.suffix(itemCountToDisplay))
                    .frame(height: 250)
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(indicator.name(isEn: false))
        .onAppear(perform: onAppear)
        .alert("エラー", isPresented: $didError, actions: {})
    }
    
    private var periodPicker: some View {
        Picker("Period", selection: $selectedPeriod) {
            ForEach(Period.allCases, id: \.self) { period in
                Text(period.rawValue).tag(period)
            }
        }
        .pickerStyle(.segmented)
        .onChange(of: selectedPeriod) { period in
            let _1Y = 12 / indicator.updateCycle
            switch period {
            case ._1Y: itemCountToDisplay = _1Y
            case ._5Y: itemCountToDisplay = _1Y * 5
            case ._10Y: itemCountToDisplay = _1Y * 10
            case .all: itemCountToDisplay = items.count
            }       
            if let lastItem = items.last { activeItem = lastItem }
        }
    }
    
    private var activeItemValue: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return HStack {
            Text(dateFormatter.string(from: activeItem.date))
                .foregroundStyle(.secondary)
            Text(String(activeItem.value))
                .font(.title2.bold())
        }
    }
    
    private func lineChart(_ items: [Item]) -> some View {
        Chart(items) {
            LineMark(
                x: .value("date", $0.date),
                y: .value("value", $0.value)
            )
            .interpolationMethod(.catmullRom)
            
            if activeItem.date ==  $0.date {
                RuleMark(x: .value("date", activeItem.date))
                    .foregroundStyle(.gray)
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                guard let date: Date = proxy.value(atX: value.location.x) else { return }
                                if let item = items.min(by: {
                                    abs($0.date.distance(to: date)) < abs($1.date.distance(to: date))
                                }) {
                                    activeItem = item
                                }
                                
                            }
                    )
            }
        }
        .chartYScale(domain: .automatic(includesZero: false))
    }
    
    private func onAppear() {
        Task {
            do {
                isLoading = true; defer { isLoading = false }
                items = try await API.fetch(indicator: indicator)
                activeItem = items.last!
                itemCountToDisplay = items.count
            } catch {
                didError = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(indicator: .GDP)
    }
}
