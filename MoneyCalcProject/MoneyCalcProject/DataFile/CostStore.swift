//
//  costStore.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import Foundation
import Combine

// 책에 있는 car 예제에 있는 json 파일에서 데이터 뽑는 것과 동일합니다.
class CostStore: ObservableObject {
    @Published var costs: [Cost]
    
    init (costs: [Cost] = []) {
        self.costs = costs
    }
}
