////
////  AddNewTrip.swift
////  MoneyCalcProject
////
////  Created by 진준호 on 2022/11/08.
////
//
//import SwiftUI
//
//struct AddNewTrip: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    @ObservedObject var costStore: CostStore
//    
//    @State var name: String = ""
//    @State var days: String = ""
//    @State var memberString: String = ""
//    @State var memo: String = ""
//    
//    var body: some View {
//        Form {
//            DataInput(title: "name", userInput: $name)
//            DataInput(title: "days", userInput: $days)
//            DataInput(title: "memberString", userInput: $memberString)
//            DataInput(title: "memo", userInput: $memo)
//            
//            Button(action: addNewTrip) {
//                Text("New Trip")
//            }
//        }
//    }
//    
//    func addNewTrip() {
//        let newTrip = Cost(id: UUID().uuidString, name: name, days: days, memberString: memberString, memberArray: [], memo: memo, costArray: [[]])
//        
//        costStore.costs.append(newTrip)
//        dismiss()
//    }
//}
//
//struct DataInput: View {
//    var title: String
//    @Binding var userInput: String
//    
//    var body: some View {
//        VStack(alignment: HorizontalAlignment.leading) {
//            Text(title)
//                .font(.headline)
//            TextField("Enter \(title)", text: $userInput)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//        .padding()
//    }
//}
//
//struct AddNewTrip_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewTrip(costStore: CostStore(costs: costData))
//    }
//}
