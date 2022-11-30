//
//  Cost.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import Foundation

// 책에 있는 car 예제에 있는 json 파일에서 데이터 뽑는 것과 동일합니다.
struct Cost: Codable, Identifiable {
    var id: String
    var name: String
    var days: String
    var memberString: String
    var memberArray: [String]
    var memo: String
    var costArray: [[String]]
    
    var perArray: [Int]
}
