//
//  WeatherViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 05.11.2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    var forecast: [Forecast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forecast") as! ForecastTableViewCell
        cell.dateLabel.text = "\(forecast[indexPath.row].list[indexPath.row].dtTxt)"
        cell.tempLabel.text = "\(forecast[indexPath.row].list[indexPath.row].main.temp)"
        
        return cell
    }
    
    
}
