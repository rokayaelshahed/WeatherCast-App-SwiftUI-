//
//  Service.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//

import Foundation

class WeatherAPI: ObservableObject {
    @Published var weatherData: WeatherResponse?

    func fetchWeather(city : String) {
        let apiKey = "3c202a6c84a1490cb3c122641251202"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=3&aqi=yes&alerts=no"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.weatherData = decodedData
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}
