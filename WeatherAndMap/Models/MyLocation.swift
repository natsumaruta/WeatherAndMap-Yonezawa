//
//  MyLocation.swift
//  WeatherAndMap
//
//  Created by 米澤菜摘子 on 2025/02/16.
//

import CoreLocation

struct MyLocation: Identifiable {
    let id = UUID()
    let name: String //地域の地名
    let coordinate: CLLocationCoordinate2D //タップしたところの地図上の座標
}
