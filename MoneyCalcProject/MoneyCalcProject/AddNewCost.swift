//
//  AddNewCost.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

struct AddNewCost: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var costStore: CostStore
    
    @State var 
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddNewCost_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCost()
    }
}
