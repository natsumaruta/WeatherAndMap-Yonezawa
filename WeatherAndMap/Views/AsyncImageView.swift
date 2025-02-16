//
//  AsyncImageView.swift
//  WeatherAndMap
//
//  Created by 米澤菜摘子 on 2025/02/16.
//

import SwiftUI

struct AsyncImageView: View {
    // 画像URLの文字列
    let urlStr: String
    var body: some View {
        // URL型に変換できたらAsyncImageで画像を取得
        if let url = URL(string: urlStr){
            AsyncImage(url: url){image in
                image //この部分が取得した画像を表示するビュー
                    .resizable()
                
            }placeholder: { //画像がないときや読み込み中の表示
                ProgressView() //進捗とかのインジケータのビュー
                    .scaledToFit()
            }
        }else{
            Text("No Image")
        }
    }
}

#Preview {
    // 八幡平氏の市章画像のURL文字列
    let urlStr = "https://www.city.hachimantai.lg.jp/img/common/top_logo.png"
    AsyncImageView(urlStr: urlStr)
}
