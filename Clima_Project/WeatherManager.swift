//
//  WeatherManager.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-16.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeatherTemperature(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    private let weatherURL = API.weatherPath
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error!)
                return
            }
            guard let safeData = data else {
                return
            }
            if let weather = parseJSON(safeData) {
                delegate?.didUpdateWeatherTemperature(self, weather)
            }
        }
        task.resume()
    }
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let name = decodedData.name
            
            let weatherModel = WeatherModel(conditionalId: id, cityName: name, temperature: temperature)
            print(weatherModel.tempetarureString)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
