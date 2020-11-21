//
//  PersistanceForecast.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation
import RealmSwift


class ForecastWeather: Object {
    @objc dynamic var date = String()
    @objc dynamic var temperature = Double()
}


class PersistanceForecastWeather {
    static let share = PersistanceForecastWeather()
    var forecastWeather: [ForecastWeather] = []
    
    let relam = try! Realm()
    
    func addForForecastWeather(forecast: ForecastWeather){
        try! relam.write() {
            relam.add(forecast)
        }
    }
    func loadForecastFromDB()->[ForecastWeather]{
        for w in relam.objects(ForecastWeather.self) {
            forecastWeather.append(w)
        }
        return forecastWeather
    }
}
