//
//  Item.swift
//  USEconomicIndicators
//
//  Created by Shigenari Oshio on 2022/12/03.
//

import Foundation

struct Item: Decodable, Identifiable {
    var id: Date { date }
    var date: Date = .init()
    var value: Double = 0
}
