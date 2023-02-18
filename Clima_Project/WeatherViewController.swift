//
//  WeatherViewController.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-15.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionalImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        searchTextField.endEditing(true)
        guard let city = searchTextField.text else {
            return
        }
        print(city)
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        guard let city = searchTextField.text else {
            return false
        }
        print(city)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type some"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else {
            return
        }
        weatherManager.fetchWeather(cityName: city)
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func didUpdateWeatherTemperature(_ weatherManager: WeatherManager,_ weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            temperatureLabel.text = weather.tempetarureString
            cityLabel.text = weather.cityName
            conditionalImageView.image = UIImage(systemName: weather.conditionalName)
        }
    }
}
