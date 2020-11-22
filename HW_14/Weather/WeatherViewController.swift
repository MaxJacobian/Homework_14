//
//  WeatherViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tempNow: UILabel!
    var forecastMain: [ForecastWeather] = []
    var tempFromDB:[Weather] = []
    var temp =  Double()
    var forecastMainFromServer: Forecast?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        tempFromDB = PersistanceWeather.share.loadedWeatherData()
        forecastMain = PersistanceForecastWeather.share.loadForecastFromDB()
       
       


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = LoaderWeather()
        loader.delegate = self
        loader.loaderWeather()
 
       
        
        
        let loaderForecast = LoaderForecast()
        loaderForecast.delegate = self
        loaderForecast.loaderForecast()
        
        
      
    tempNow.text = "\(round(tempFromDB.isEmpty ? temp : tempFromDB[0].weatherCash - 273.5) <= 0.3 ? 0 : round(tempFromDB[0].weatherCash - 273.5))°C"
        
        
    }
    

}
extension WeatherViewController: LoaderForecastDelegate {
    func forecastDelegate(forecast: Forecast) {
        self.forecastMainFromServer = forecast
        for b in forecast.list {
            let f = ForecastWeather()
            f.date = b.dtTxt
            f.temperature = b.main.temp
            PersistanceForecastWeather.share.addForForecastWeather(forecast: f)
         
        }
    }
}
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return forecastMain.count
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forecast") as! ForecastTableViewCell
        cell.dateLabel.text = "\( forecastMain.isEmpty ? String(describing:forecastMainFromServer?.list[indexPath.row].dtTxt) : forecastMain[indexPath.row].date)"
        cell.tempLabel.text = "\(round( forecastMain.isEmpty ? forecastMainFromServer!.list[indexPath.row].main.temp - 273.15:  forecastMain[indexPath.row].temperature  - 273.15))°C"
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        
        return cell
    }
    
    
}

extension WeatherViewController: LoaderWeatherDelegate {
    func loaderWeatherDelegate(welcom: Welcome) {
        self.temp = welcom.main.temp
        let w = Weather()
        w.weatherCash = welcom.main.temp
        PersistanceWeather.share.createCashTemperature(temp: w)
      
        
    }
    
}
