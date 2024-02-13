//
//  CityList.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import Foundation

struct CityList: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    //let coord: [Coord]
}
