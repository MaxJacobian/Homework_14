//
//  ForecastLoader.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import Foundation
import Alamofire

protocol LoaderForecastDelegate {
    func forecastDelegate(forecast: Forecast)
   
}


class LoaderForecast {
    var weatherForecast: [ListForecast] = []
    var delegate: LoaderForecastDelegate?
    func loaderForecast(){
        AF.request("http://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=90439e83f6127ff1e44db61fb94a53b3").responseData {
            response in
            switch response.result {
            
            case .success(let data):
                
                let forecastData: Forecast =  try! JSONDecoder().decode(Forecast.self, from: data)
                self.delegate?.forecastDelegate(forecast: forecastData)
                
            case .failure(let error):
                
                //show error here
                
                print(error)

                        }

           
            
        }
    
    }
}
