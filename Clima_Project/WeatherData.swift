//
//  WeatherData.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-16.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
