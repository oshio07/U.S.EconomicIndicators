//
//  Indicator.swift
//  USEconomicIndicators
//
//  Created by Shigenari Oshio on 2022/12/03.
//

import Foundation

enum Indicator: String {
    case GDP, realGDP,  realGDPPerCapita,  federalFunds,  CPI,  retailSales,  consumerSentiment,  durableGoods,  unemploymentRate,  totalNonfarmPayroll,  industrialProductionTotalIndex,  newPrivatelyOwnedHousingUnitsStartedTotalUnits,  totalVehicleSales
    
    typealias Month = Int
    var updateCycle: Month {
        switch self {
        case .GDP, .realGDP, .realGDPPerCapita: return 3
        default: return 1
        }
    }
    
    enum Category: String, CaseIterable {
        case 景気・金融, 消費, 雇用, 産業
        
        var indecators: [Indicator] {
            switch self {
            case .景気・金融: return [.GDP, .realGDP, .realGDPPerCapita, .federalFunds]
            case .消費: return [.CPI, .retailSales, .consumerSentiment]
            case .雇用: return [.unemploymentRate, .totalNonfarmPayroll]
            case .産業: return [.durableGoods, .industrialProductionTotalIndex, .newPrivatelyOwnedHousingUnitsStartedTotalUnits, .totalVehicleSales]
            }
        }
    }
    
    func name(isEn: Bool) -> String {
        switch self {
        case .GDP: return isEn ? "Gross Domestic Product" : "国内総生産(GDP)"
        case .realGDP: return isEn ? "Real Gross Domestic Product" : "実質GDP"
        case .realGDPPerCapita: return isEn ? "Real gross domestic product per capita" : "一人当たり実質GDP"
        case .federalFunds: return isEn ? "Federal Funds Effective Rate" : "フェデラルファンズレート"
        case .CPI: return isEn ? "Consumer Price Index for All Urban Consumers: All Items in U.S. City Average" : "消費者物価指数(CPI)"
        case .retailSales: return isEn ? "Advance Retail Sales: Retail Trade" : "小売売上高"
        case .consumerSentiment: return isEn ? "University of Michigan: Consumer Sentiment" : "消費者信頼感指数"
        case .durableGoods: return isEn ? "Manufacturers' New Orders: Durable Goods" : "耐久財受注"
        case .unemploymentRate: return isEn ? " Unemployment Rate" : "失業率"
        case .totalNonfarmPayroll: return isEn ? "All Employees, Total Nonfarm" : "非農業部門雇用者数"
        case .industrialProductionTotalIndex: return isEn ? "Industrial Production: Total Index" : "鉱工業生産指数"
        case .newPrivatelyOwnedHousingUnitsStartedTotalUnits: return isEn ? "New Privately-Owned Housing Units Started: Total Units" : "住宅着工件数"
        case .totalVehicleSales: return isEn ? "Total Vehicle Sales" : "自動車販売台数"
        }
    }
}
