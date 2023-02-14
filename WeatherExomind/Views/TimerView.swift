//
//  TimerView.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import SwiftUI

struct TimerView: View {
  @ObservedObject var forecast = WeatherViewModel()
  @State private var value: CGFloat = 0
  @State private var count = 0
  @State private var city = ""
  @State private var weather: Weather?
  let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
  var maxWidth: CGFloat  = 360
  var cities = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"]
  var intervals: [CGFloat] = [0.00, 60.00, 120.00, 180.00, 240.00]
  var body: some View {
    VStack {
      Spacer()
      if value != 360.00 {
        ZStack(alignment: .leading) {
          Capsule()
            .frame(width: maxWidth, height: 25)
            .foregroundColor(.blue.opacity(0.2))
          
          withAnimation(.easeOut) {
            Capsule()
              .foregroundColor(.blue.opacity(0.4))
              .frame(width: value, height: 25, alignment: .leading)
          }
        }
      } else {
        VStack {
          ScrollView(showsIndicators: false){
            ForEach(forecast.forecasts, id: \.id) { weather in
              ForecastCell(weather: weather)
            }
          }
          Button {
            value = 0
            forecast.forecasts = [Weather]()
          } label: {
            Text("Recommencer")
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)
              .cornerRadius(15)
          }
        }
      }
      Text("*\(forecast.loadingDialog(count))*")
        .fontWeight(.thin)
        .onReceive(timer) { _ in
          if value < maxWidth {
            if intervals.contains(value) {
              // Je trouve le premier index qui correspond à 'value', qui est mis à jour chaque seconde
              if let cityIndex = intervals.firstIndex(of: value) {
                forecast.makeAPICall(city: cities[cityIndex])
              }
            }
            // La largeur de la barre étant égale à 360, en incrémentant 'value' de 6 par seconde,
            // la barre se remplira en 60 secondes: 60 * 6 = 360
            value += 6
          }
          if count < 60 {
            count += 1
          } else if count == 60 {
            count = 0
          }
        }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
  }
}
