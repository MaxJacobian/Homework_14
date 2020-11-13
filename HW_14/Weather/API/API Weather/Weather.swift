//
//  Weather.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation

struct Main: Codable {
    let temp, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
    init(from decoder: Decoder) throws {
        let conteiner =  try decoder.container(keyedBy: CodingKeys.self)
        self.temp  = try! conteiner.decode(Double.self, forKey: .temp)
        self.feelsLike = try! conteiner.decode(Double.self, forKey: .feelsLike)
    }
}

struct Weather: Codable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.main = try! container.decode(String.self, forKey: .main)
        self.weatherDescription = try! container.decode(String.self, forKey: .weatherDescription)
    }
}

struct Wind: Codable {
    let speed: Int
}
struct Welcome: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    enum CodingKeys: String,CodingKey {
        case name
        case weather
        case main
        case wind
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.main = try! container.decode(Main.self, forKey: .main)
        self.name = try! container.decode(String.self, forKey: .name)
        self.weather = try! container.decode([Weather].self, forKey: .weather)
        self.wind = try! container.decode(Wind.self, forKey: .wind)
    }
}
