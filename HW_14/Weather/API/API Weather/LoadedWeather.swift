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
        AF.request("http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=d2aab6019257b9173e86663513cec7a4").responseData {
            response in
            switch response.result {
            
            case .success(let data):
                
                let welcom: Welcome = try! JSONDecoder().decode(Welcome.self, from: data)
                self.delegate?.loaderWeatherDelegate(welcom: welcom)
            case .failure(let error):
                print(error)
            }
            

      
        
    }
    
    
}

}
