//
//  loadData.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import Foundation

var previewWeather: Weather = load("WeatherPreview.json")

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError("Impossible de trouver le fichier \(filename) dans le module principal")
  }
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Impossible de charger le fichier depuis le module principal \n \(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Impossible de traiter le fichier \(filename) en tant que \(T.self): \(error)")
  }
}
