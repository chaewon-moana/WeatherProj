//
//  WeatherDaily.swift
//  WeatherProj
//
//  Created by cho on 2/11/24.
//

import Foundation

struct WeatherDaily: Decodable {
    //let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

struct City: Decodable {
    let id: Int
    let name: String
    //let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double
//}

struct List: Decodable {
    let dt: Int
    let main: MainClass
    let weather: [WeatherForecast]
    let clouds: CloudsDay
    let wind: WindDay
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: SysDay
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct CloudsDay: Decodable {
    let all: Int
}

struct MainClass: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct SysDay: Decodable {
    let pod: Pod
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}

struct WeatherForecast: Decodable {
    let id: Int
    let main: MainEnum
    let description: String
    let icon: String
}

//enum Description: String, Decodable {
//    case brokenClouds = "broken clouds"
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//}

enum MainEnum: String, Decodable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

struct WindDay: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}
