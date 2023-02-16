//
//  WeatherManager.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-16.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeatherTemperature(weather: WeatherModel)
}

struct WeatherManager {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=d5837790e5a5eac0d3414225e9011572&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(url: urlString)
    }
    private func performRequest(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else {
                return
            }
            if let weather = parseJSON(weatherData: safeData) {
                delegate?.didUpdateWeatherTemperature(weather: weather)
            }
        }
        task.resume()
    }
    private func parseJSON(weatherData: Data) -> WeatherModel? {
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
            print(error)
            return nil
        }
    }
}
