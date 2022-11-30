//
//  CostData.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import Foundation

// 책에 있는 car 예제에 있는 json 파일에서 데이터 뽑는 것과 동일합니다.
var costData: [Cost] = loadJson("costData.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("\(filename) not found")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }
}
