//
//  WeatherViewController.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-15.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionalImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
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
    
    @IBAction func locationTapped(_ sender: UIButton) {
        locationManager.requestLocation()
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

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingHeading()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            print("Coordinate lat \(lat), lon \(lon)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
