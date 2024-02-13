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
    
    func callRequest(compleionHandler: @escaping ((WeatherModel) -> Void)) {
        //lat=37.654165&lon=127.049696
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696&units=metric&lang=kr&appid=\(APIKey.apiKey)"
        
        AF.request(url).responseDecodable(of: WeatherModel.self) { response in
            switch response.result {
            case .success(let success):
                //dump(success)
                compleionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func callRequestDaily(completionHandler: @escaping ((WeatherDaily) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=37.654165&lon=127.049696&units=metric&lang=kr&appid=\(APIKey.apiKey)"
        
        AF.request(url).responseDecodable(of: WeatherDaily.self) { response in
            switch response.result {
            case .success(let success):
                //dump(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
