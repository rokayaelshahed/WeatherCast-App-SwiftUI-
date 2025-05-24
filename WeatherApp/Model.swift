//
//  Model.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: WeatherCondition
    let humidity: Int
    let feelslike_c: Double
    let vis_km: Double
    let pressure_mb: Double
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    let id = UUID()
    let date: String
    let day: DayWeather
    let hour: [HourWeather]
}

struct DayWeather: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: WeatherCondition
}
struct HourWeather: Codable, Identifiable {
    let id = UUID()
    let time: String
    let temp_c: Double
    let condition: WeatherCondition 
}
