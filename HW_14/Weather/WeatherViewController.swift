//
//  WeatherViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var tempNow: UILabel!
    var forecastMain: [ForecastWeather] = []
    var tempFromDB:[Weather] = []
    var temp =  Weather()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loader = LoaderWeather()
        loader.delegate = self
        loader.loaderWeather()
        tempFromDB = PersistanceWeather.share.loadedWeatherData()
        
        tempNow.text = "\(round(tempFromDB[0].weatherCash - 273.5) <= 0.3 ? 0 : round(tempFromDB[0].weatherCash - 273.5))°C"
        
        let loaderForecast = LoaderForecast()
        loaderForecast.delegate = self
        loaderForecast.loaderForecast()
        forecastMain = PersistanceForecastWeather.share.loadForecastFromDB()


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

}
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastMain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forecast") as! ForecastTableViewCell
        cell.dateLabel.text = "\(forecastMain[indexPath.row].date)"
        cell.tempLabel.text = "\(round(forecastMain[indexPath.row].temperature  - 273.5))°C"
        
        return cell
    }
    
    
}
extension WeatherViewController: LoaderForecastDelegate {
    func forecastDelegate(forecast: Forecast) {
        
        for b in forecast.list {
            let f = ForecastWeather()
            f.date = b.dtTxt
            f.temperature = b.main.temp
            PersistanceForecastWeather.share.addForForecastWeather(forecast: f)

        }
        
        
    }
    
    
}
extension WeatherViewController: LoaderWeatherDelegate {
    func loaderWeatherDelegate(welcom: Welcome) {
        
        let w = Weather()
        w.weatherCash = welcom.main.temp
        PersistanceWeather.share.createCashTemperature(temp: w)
//        tempNow.text = "\(round(tempFromDB[0].weatherCash - 273.5) <= 0.3 ? 0 : round(tempFromDB[0].weatherCash - 273.5))°C"
        
    }
    
}
