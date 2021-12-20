//
//  Alert.swift
//  Drink
//
//  Created by 이니텍 on 2021/12/20.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    let isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm" //시간:분
        return timeFormatter.string(from: date)
    }
    
    var merdiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a" //오전오후 구분
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
