//
//  HoursView.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//

import SwiftUI
struct HoursView: View {
    let forecast: ForecastDay

    var body: some View {
        ZStack {
            backgroundView()

            VStack {
                List(forecast.hour.prefix(6), id: \.id) { hourData in
                    HStack {
                        Text(hourData.time) //
                            .bold()

                        Spacer().frame(width: 100)

                        AsyncImage(url: URL(string: "https:\(hourData.condition.icon)")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 30, height: 30)

                        Text("\(Int(hourData.temp_c))°C")
                    }
                    .padding(.all)
                    .background(Color.clear)
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }.padding(.all)
        }.background(Color.clear)
        .edgesIgnoringSafeArea(.bottom)
    }
}





#Preview {
    HoursView(forecast: ForecastDay(
        date: "2025-02-12",
        day: DayWeather(
            maxtemp_c: 20.0,
            mintemp_c: 10.0,
            condition: WeatherCondition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png")
        ), hour: [
            HourWeather(time: "12:00 PM", temp_c: 15.0, condition: WeatherCondition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png")),
            HourWeather(time: "1:00 PM", temp_c: 16.0, condition: WeatherCondition(text: "Partly Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")),
            HourWeather(time: "2:00 PM", temp_c: 17.0, condition: WeatherCondition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")),
            HourWeather(time: "3:00 PM", temp_c: 18.0, condition: WeatherCondition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png")),
            HourWeather(time: "4:00 PM", temp_c: 19.0, condition: WeatherCondition(text: "Rainy", icon: "//cdn.weatherapi.com/weather/64x64/day/296.png")),
            HourWeather(time: "5:00 PM", temp_c: 20.0, condition: WeatherCondition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"))
        ]
    ))
}
