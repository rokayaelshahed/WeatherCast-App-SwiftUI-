//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//
import SwiftUI

struct WeatherView: View {
    @StateObject var weatherAPI = WeatherAPI()
    @StateObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            ZStack {
                backgroundView()
                
                VStack {
                    if let city = locationManager.cityName {
                                    
                    if let weather = weatherAPI.weatherData {
                        VStack {
                            Text(weather.location.name)
                                .font(.largeTitle)
                                .bold()
                            
                            Text(weather.current.condition.text)
                                .font(.title2)
                            
                            Text("\(Int(weather.current.temp_c))°C")
                                .font(.system(size: 50, weight: .bold))
                            
                            Text("H: \(Int(weather.forecast.forecastday[0].day.maxtemp_c))°C L: \(Int(weather.forecast.forecastday[0].day.mintemp_c))°C")
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        
                 //       Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("3-DAY FORECAST")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.leading)

                       
                                VStack(alignment: .leading) {
                                    ForEach(weather.forecast.forecastday) { day in
                                        NavigationLink(destination: HoursView(forecast: day)) {
                                            ForecastRow(day: day)
                                        }
                                    }
                                }
        
                        }
                        .frame( alignment: .leading)
                        VStack(alignment: .leading) {
                            LazyVGrid(columns: [GridItem(.flexible(),spacing: 10), GridItem(.flexible(),spacing: 10)], spacing: 20) {
                            WeatherDetail(title: "Humidity", value: "\(weather.current.humidity)%")
                            WeatherDetail(title: "Pressure", value: "\(Int(weather.current.pressure_mb)) mb")
                            WeatherDetail(title: "Visibility", value: "\(Int(weather.current.vis_km)) km")
                            WeatherDetail(title: "Feels like", value: "\(Int(weather.current.feelslike_c)) °C")

                        }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.leading, 10)
                      // .padding()

                    } else {
                        ProgressView("Loading...")
                            .onAppear {
                                weatherAPI.fetchWeather(city: city)
                                }
                            }
                    }
                }
            }
          .edgesIgnoringSafeArea(.all)
        }
    }
}



func backgroundView() -> some View {
    let hour = Calendar.current.component(.hour, from: Date())
    let background = hour >= 6 && hour < 18 ? "morning-bg" : "night-bg"
    return Image(background)
        .resizable()
        .scaledToFill()
        .overlay(Color.black.opacity(0.3))
}


struct ForecastRow: View {
    let day: ForecastDay
    
    var body: some View {
        HStack {
            Text(day.date)
                .font(.headline)
                .foregroundColor(.white)
            AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            Text("\(Int(day.day.mintemp_c))°C - \(Int(day.day.maxtemp_c))°C")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
    }
}


struct WeatherDetail: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
    }
}



#Preview {
    WeatherView()
}
