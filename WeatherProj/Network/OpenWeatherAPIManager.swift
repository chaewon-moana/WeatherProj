//
//  OpenWeatherAPIManager.swift
//  WeatherProj
//
//  Created by cho on 2/9/24.
//

import Foundation
import Alamofire

class OpenWeatherAPIManager {
    
    static let shared = OpenWeatherAPIManager()
    
    func callRequest() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696&appid=\(APIKey.apiKey)"
        
        AF.request(url).responseDecodable(of: WeatherModel.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
