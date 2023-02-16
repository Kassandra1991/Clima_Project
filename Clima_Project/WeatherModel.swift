//
//  WeatherModel.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-16.
//

import Foundation

struct WeatherModel {
    let conditionalId: Int
    let cityName: String
    let temperature: Double
    var tempetarureString: String {
        String(format: "%.1f", temperature)
    }
    var conditionalName: String {
        switch conditionalId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
