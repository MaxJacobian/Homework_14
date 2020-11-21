//
//  PersistanceWeather.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation
import RealmSwift



class Weather: Object {
    @objc dynamic var weatherCash = Double()
}
class PersistanceWeather {
    static let share = PersistanceWeather()
    var storage: [Weather] = []
    
    let relam = try! Realm()
    
    func createCashTemperature(temp: Weather){
    try! relam.write() {
        relam.add(Weather(value: temp))
      }
   }
    func loadedWeatherData()-> [Weather] {
        for temp in relam.objects(Weather.self) {
            storage.append(temp)
        }
        return storage
   }
}


