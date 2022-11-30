//
//  ContentView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        // 탭뷰를 이용하기 위해 사용
        TabView(selection: $tabSelection) {
            // MainView를 보여줌
            NavigationView {
                MainView()
            }.tabItem {
                Image(systemName:"house.fill")
                Text("홈")
            }.tag(1)
            
            // CostListView를 보여줌
            NavigationView {
                CostListView()
            }.tabItem {
                Image(systemName:"dollarsign")
                Text("비용 내역")
            }.tag(2)
            
            // CostResultView를 보여줌
            NavigationView {
                CostResultView()
            }.tabItem {
                Image(systemName:"chart.pie")
                Text("비용 결과")
            }.tag(3)
            
            // CostDivideView를 보여줌
            NavigationView {
                CostDivideView()
            }.tabItem {
                Image(systemName:"divide")
                Text("정산하기")
            }.tag(4)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SelectedData())
    }
}
