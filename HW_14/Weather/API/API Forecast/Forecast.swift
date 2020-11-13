//
//  Forecast.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation
struct MainForecast: Codable {
    let temp: Double
}
struct ListForecast: Codable {
    let main: MainForecast
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main
        case dtTxt = "dt_txt"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.main = try! container.decode(MainForecast.self, forKey: .main)
        self.dtTxt = try! container.decode(String.self, forKey: .dtTxt)
    }
}
struct Forecast: Codable {
    let list: [ListForecast]
    enum CodingKeys: String, CodingKey {
        case list
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try! container.decode([ListForecast].self, forKey: .list)
    }
}
