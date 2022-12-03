//
//  API.swift
//  USEconomicIndicators
//
//  Created by Shigenari Oshio on 2022/12/03.
//

import Foundation

struct API {
    static func fetch(indicator: Indicator) async throws -> [Item] {
        let url: URL = .init(string: "https://financialmodelingprep.com/api/v4/economic?name=\(indicator.rawValue)&apikey=\(APIKey.key)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let GDPs = try JSONDecoder().decode([ItemDTO].self, from: data)
        return try GDPs.reversed().map { try Item($0) }
    }
}

private struct ItemDTO: Decodable, Hashable {
    let date: String
    let value: Double
}

private extension Item {
    init(_ itemDTO: ItemDTO) throws {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: itemDTO.date) {
            self.date = date
            self.value = itemDTO.value
        } else {
            throw NSError()
        }
    }
}
