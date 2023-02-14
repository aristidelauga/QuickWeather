//
//  Weather.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import Foundation

struct Weather: Codable {
  let coordinates: Coordinates
  let weather: [WeatherElements]
  let main: MainForecast
  let wind: WindForecast
  let clouds: CloudForecast
  let dt: Date
  let sun: CountryInfo
  let id: Int
  let name: String
  
  
  enum WeatherCodingKeys: String, CodingKey {
    case coordinates = "coord"
    case weather, main, wind, clouds
    case date = "dt"
    case sun = "sys"
    case id, name
  }
  
  struct Coordinates: Codable {
    let lat, lon: Double
  }
  
  struct WeatherElements: Codable {
    let id: Int
    let main, description, icon: String
    var iconURL: URL {
      let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
      return URL(string: urlString) ?? URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!
    }
  }
  
  struct MainForecast: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
      case temp, pressure, humidity
      case feelsLike = "feels_like"
      case tempMin = "temp_min"
      case tempMax = "temp_max"
    }
  }
  
  struct WindForecast: Codable {
    let speed: Double
    let deg: Int
  }
  
  struct CloudForecast: Codable {
    var all: Int
  }
  
  struct CountryInfo: Codable {
    let id: Int
    let sunrise, sunset: Date
  }
  
}
