//
//  SelectedData.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import Foundation
import Combine

// 선택한 모임이 어떤 것인지 다른 뷰에서 전달하기 위해서 정의한 ObservableObject
class SelectedData: ObservableObject {
    @Published var selectedIndex: Int = 0
    // 더미를 위한 변수... 추후에 알고리즘이 개선된다면 굳이 필요 없을 수 있음
    @Published var costDataCount: Int = 3
    
    func costDataCountPlus() {
        costDataCount += 1
    }
}
