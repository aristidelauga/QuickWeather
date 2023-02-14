//
//  WeatherViewModel.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
  @Published var forecasts = [Weather]()
  private var apiKey = "VOTRECLÉAPI"
  
  func makeAPICall(city: String,
                   _ dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                   _ keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city),fr&appid=\(apiKey)&units=metric") else {
      fatalError("URL incomplète ou défaillante") }
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        let decoded = try? decoder.decode(Weather.self, from: data)
        if let decoded = decoded {
          DispatchQueue.main.async {
            self.forecasts.append(decoded)
          }
        }
      }
    }
  }
}
