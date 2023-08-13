//
//  ContentView.swift
//  Weather
//
//  Created by kirshi on 8/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                if let location = locationManager.location {
                    if weather != nil {
                        WeatherView(weather: weather)
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print("Error getting weather", error)
                                }
                            }
                    }
                } else {
                    if(locationManager.isLoading){
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
                
            }
        }
        .background(Color(red: 0.084, green: 0.075, blue: 0.344))
    .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
