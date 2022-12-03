//
//  HomeView.swift
//  USEconomicIndicators
//
//  Created by Shigenari Oshio on 2022/12/03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(Indicator.Category.景気・金融.rawValue) {
                    ForEach(Indicator.Category.景気・金融.indecators, id: \.self) { indicator in
                        NavigationLink(indicator.name(isEn: false), value: indicator)
                    }
                }
                Section(Indicator.Category.消費.rawValue) {
                    ForEach(Indicator.Category.消費.indecators, id: \.self) { indicator in
                        NavigationLink(indicator.name(isEn: false), value: indicator)
                    }
                }
                Section(Indicator.Category.雇用.rawValue) {
                    ForEach(Indicator.Category.雇用.indecators, id: \.self) { indicator in
                        NavigationLink(indicator.name(isEn: false), value: indicator)
                    }
                }
                Section(Indicator.Category.産業.rawValue) {
                    ForEach(Indicator.Category.産業.indecators, id: \.self) { indicator in
                        NavigationLink(indicator.name(isEn: false), value: indicator)
                    }
                }
            }
            .navigationTitle("米国経済統計")
            .navigationDestination(for: Indicator.self) { indicator in
                DetailView(indicator: indicator)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
