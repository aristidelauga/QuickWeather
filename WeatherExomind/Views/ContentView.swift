//
//  ContentView.swift
//  WeatherExomind
//
//  Created by Aristide LAUGA on 14/02/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var forecast = WeatherViewModel()
    var body: some View {
        NavigationStack {
          VStack(spacing: 10) {
              Text("Bienvenue sur l'app **Météo** ! \nVeuillez appuyer sur le bouton ci-dessous pour commencer")
              .multilineTextAlignment(.center)
            NavigationLink {
              TimerView()
            } label: {
              Text("Commencer")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(15)
            }
          }
          .padding()
          .onAppear { forecast.forecasts = [Weather]() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

