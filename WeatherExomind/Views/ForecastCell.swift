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
        
        Text("Feels like : \(Int(weather.main.feelsLike.rounded(.awayFromZero)))ºC")
          .fontWeight(.thin)
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
