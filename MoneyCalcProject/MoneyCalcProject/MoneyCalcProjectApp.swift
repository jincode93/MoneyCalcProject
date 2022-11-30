//
//  MoneyCalcProjectApp.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

@main
struct MoneyCalcProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SelectedData())
        }
    }
}
