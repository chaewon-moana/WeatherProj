//
//  WeatherModel.swift
//  WeatherProj
//
//  Created by cho on 2/9/24.
//

import Foundation

struct Model: Decodable {
    let weatherModel: [WeatherModel]
}
struct WeatherModel: Decodable {
    //let coord: Coord
    let weather: [Weather]
    //let base: String
    let main: Main
    //let visibility: Int
    //let wind: Wind
    //let clouds: Clouds
    //let dt: Int
    //let sys: Sys
    //let timezone: Int
    let id: Int
    let name: String
    //let cod: Int
}

struct Coord: Decodable {
    let lon: Double //경도
    let lat: Double //위도
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    //let pressure: Int
    //let humidity: Int
    
    var calTemp: String {
        return String(Int(round(temp)))
    }
    
    var calMaxTemp: String {
        return String(Int(round(temp_max)))
    }
    
    var calMinTemp: String {
        return String(Int(round(temp_min)))
    }
    //let sea_level: Int
    //let grnd_level: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    //let gust: Double
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
