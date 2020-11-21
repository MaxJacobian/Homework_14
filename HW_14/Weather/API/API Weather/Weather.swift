//
//  Weather.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation

struct Main: Codable {
    let temp: Double
    enum CodingKeys: String, CodingKey {
        case temp
     }
    init(from decoder: Decoder) throws {
        let conteiner =  try decoder.container(keyedBy: CodingKeys.self)
        self.temp  = try! conteiner.decode(Double.self, forKey: .temp)

    }
}
struct Welcome: Codable {
    let main: Main
    
}

