//
//  WeatherViewModel.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
  @Published var forecasts = [Weather]()
  private var apiKey = "bf48e1a1a0ba2bd6a1e7c360cf158755"
  
  func loadingDialog(_ value: Int) -> String {
    var text = ""
    let firstDialogValue: [Int] = [6, 24, 42, 60]
    let secondDialogValue: [Int] = [12, 30, 48]
    let ThirdDialogValue: [Int] = [18, 36, 54]
    if firstDialogValue.contains(value) {
      text = "Nous téléchargeons les données..."
    } else if secondDialogValue.contains(value) {
      text = "C'est presque fini..."
    } else if ThirdDialogValue.contains(value) {
      text = "Plus que quelques secondes avant d'avoir le résultat..."
    }
    return text
  }
  
  func makeAPICall(city: String,
                   _ dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                   _ keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city),fr&appid=\(apiKey)&units=metric") else {
      fatalError("URL incomplète ou défaillante") }
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        let decoded = try? JSONDecoder().decode(Weather.self, from: data)
        if let decoded = decoded {
          DispatchQueue.main.async {
            self.forecasts.append(decoded)
          }
        }
      }
    }.resume()
  }
}
