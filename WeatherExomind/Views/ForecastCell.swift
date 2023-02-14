//
//  ForecastCell.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import SwiftUI

struct ForecastCell: View {
  var weather: Weather
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
        Text(weather.name)
          .font(.system(.title, design: .rounded, weight: .bold))
          .frame(width: 210, alignment: .leading)
        Text(weather.weather.first!.description.capitalized)
        
        Text("Ressenti : \(Int(weather.main.feelsLike.rounded(.awayFromZero)))ºC")
          .fontWeight(.thin)
        Text("Indice d'humidité: \(weather.main.humidity)%")
          .fixedSize(horizontal: true, vertical: false)
        HStack {
          Image(systemName: "sunrise.fill")
            .foregroundColor(Color.yellow)
            .imageScale(.large)
          Text("Lever du soleil: \(weather.sys.sunrise.formatted(date: .omitted, time: .shortened))")
            .fixedSize(horizontal: true, vertical: false)

        }
        HStack(alignment: .top) {
          Image(systemName: "sunset.fill")
            .foregroundColor(Color.yellow)
            .imageScale(.large)
          Text("Coucher du soleil: \(weather.sys.sunset.formatted(date: .omitted, time: .shortened))")
            .fixedSize(horizontal: true, vertical: false)

        }
      }
      
      Spacer()
      
      Text("\(Int(weather.main.temp.rounded(.down)))ºC")
        .font(.system(.title2, weight: .semibold))
      AsyncImage(url: weather.weather.first!.iconURL) { image in
        image.resizable()
          .frame(width: 75, height: 75)
      } placeholder: {
        ProgressView()
      }
    }
    .padding()
    .background(Color.gray.opacity(0.09)
      .padding(5)
      .cornerRadius(25))
  }
}

struct ForecastCell_Previews: PreviewProvider {
  static var previews: some View {
    ForecastCell(weather: previewWeather)
  }
}
