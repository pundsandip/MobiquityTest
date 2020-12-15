//
//  ServiceManager.swift
//  MobiquityTest
//
//  Created by Sandip Pund on 13/12/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import Foundation

class ServiceManager {
    let appId = "fae7190d7e6433ec3a45285ffcf55c86"
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?"
    static let shared = ServiceManager()
    private init() { }
    
    func fetchWeatherData(city: String, handler: @escaping(WeatherInfo?, Error?)-> Void) {
        let urlString = baseUrl + "q=\(city)&appid=\(appId)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _error = error {
                DispatchQueue.main.async {
                    handler(nil, _error)
                }
                return
            }
            if let _data = data {
                do {
                    let response = try JSONDecoder().decode(WeatherInfo.self, from: _data)
                    DispatchQueue.main.async {
                        handler(response, nil)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
