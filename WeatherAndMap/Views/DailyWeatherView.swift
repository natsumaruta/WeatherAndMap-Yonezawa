//
//  DailyWeatherView.swift
//  WeatherAndMap
//
//  Created by 米澤菜摘子 on 2025/02/16.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel //APIレスポンスの値を保持するオブジェクト
    @ObservedObject var locationManager: LocationManager //ロケーションマネージャー
    @State var weatherLocation: MyLocation? //地図上のマーカーのオブジェクト（MyLocation）を格納する変数
    var body: some View {
        ScrollView(.horizontal){ //水平方向(.horizontal)にスクロールする
            
            // レスポンスに天気予報の情報があったとき
            if let forecastsDay = weatherVM.forecast?.forecastsDay{
                
            HStack {
                ForEach(forecastsDay, id: \.self) { forecastDay in //３回繰り返して表示
                    //MARK: - 1日分の天気予報のUI
                    VStack(spacing:5) { // 各部品の間隔を５に指定
                        // 日付（年月日）
                        Text(forecastDay.toDisplayDate(forecastDay.date))
                            .font(.callout)
                        
                        // 天気アイコン画像
                        AsyncImageView(urlStr:"https:\(forecastDay.day.condition.icon)")
                            .padding()
                            .scaledToFit()

                        
                        //　天気の説明（晴れ、曇り　など）
                        Text(forecastDay.day.condition.text)
                            .font(.headline)
                        
                        //　最高気温 ℃　/ 最低　℃
                        HStack {
                            Text(forecastDay.day.maxTemp, format: .number)
                                .foregroundStyle(.red) //文字を赤に
                            Text("℃")
                                .foregroundStyle(.red)
                            Text("/")
                            Text(forecastDay.day.minTemp, format: .number)
                                .foregroundStyle(.blue) //文字を青に
                            Text("℃")
                                .foregroundStyle(.blue)
                        }
                        
                        //降水確率：　〇〇％
                        HStack {
                            Text("降水確率")
                            Text(forecastDay.day.dailyChanceOfRain, format:.number)
                            Text("%")
                        }                        
                        .font(.subheadline)//フォントを小見出しのスタイルに
                    }
                    .padding()
                    .frame(width: ScreenInfo.width / 2,
                           height: ScreenInfo.height / 3)
                    .background(.yellow.opacity(0.3))    //背景色、透過率を指定
                    .clipShape(.rect(cornerRadius: 10))  //角丸に切り取る
                }
            }
            .onAppear {
                // マーカー(weatherLocation)があるときはマーカーの位置の天気を取得
                if let weatherLocation {
                    let lat = weatherLocation.coordinate.latitude
                    let lon = weatherLocation.coordinate.longitude
                    weatherVM.request3DaysForecast(lat: lat, lon: lon)
                    print("Weather Location:", weatherLocation.name)
                    
                    // ないときはユーザーの現在地の天気を取得
                } else if let location = locationManager.location {
                    weatherVM.request3DaysForecast(
                        lat: location.coordinate.latitude,
                        lon: location.coordinate.longitude)
                    print("Location:", location)
                }
            }
            }else{
                // コピペした部分。データがないとき（または起動直後）に表示
                HStack {
                    ForEach(0...2, id: \.self) { _ in //３回繰り返して表示
                        //MARK: - 1日分の天気予報のUI
                        VStack(spacing:5) { // 各部品の間隔を５に指定
                            // 日付（年月日）
                            Text("＿＿年＿月＿日")
                            
                            // 天気アイコン画像
                            Image(systemName: "cloud.sun")//今はサンプル画像
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                            
                            //　天気の説明（晴れ、曇り　など）
                            Text("晴れのち曇り")
                            
                            //　最高気温 ℃　/ 最低　℃
                            HStack {
                                Text("最高")//数字が入る
                                Text("℃ /")
                                Text("最低")//数字が入る
                                Text("℃")
                            }
                            
                            //降水確率：　〇〇％
                            HStack {
                                Text("降水確率")
                                Text("〇〇")//数字が入る
                                Text("%")
                            }
                        }
                        .padding()
                        .frame(width: ScreenInfo.width / 2,
                               height: ScreenInfo.height / 3)
                        .background(.yellow.opacity(0.3))    //背景色、透過率を指定
                        .clipShape(.rect(cornerRadius: 10))  //角丸に切り取る
                    }
                }
            }
        }
    }
}

//#Preview {
//    @Previewable @StateObject var weatherVM = WeatherViewModel()
//    //八幡平市大更の緯度・経度
//    let lat: Double = 39.91167
//    let lon: Double = 141.093459
//    
//    DailyWeatherView(weatherVM: weatherVM)
//        .onAppear{
//            weatherVM.request3DaysForecast(lat: lat, lon: lon)
//        }
//}
