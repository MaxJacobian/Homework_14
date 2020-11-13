//
//  LoadedWeather.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation
import Alamofire
protocol LoaderWeatherDelegate {
    func loaderWeatherDelegate(welcom: Welcome)
}
class LoaderWeather{
    var delegate: LoaderWeatherDelegate?
    
    func loaderWeather(){
        AF.request("http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=90439e83f6127ff1e44db61fb94a53b3").responseData {
            response in
            let welcom: Welcome = try! JSONDecoder().decode(Welcome.self,from: response.value!)
            
            
            self.delegate?.loaderWeatherDelegate(welcom: welcom)
            
        }
        
        
    }
    
    
}

