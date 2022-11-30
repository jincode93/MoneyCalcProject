//
//  MainModalView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

struct MainModalView: View {
    // 모달창을 닫기 위한 함수인 dismiss()를 사용하기위해 선언, 아래 x버튼에 dissmiss()를 사용하기 위해 선언
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var costStore: CostStore
    @EnvironmentObject var selectedData: SelectedData
    
    // 추가된 정보들을 CostStore에 넣어주기 위해서 선언한 변수들, 다만 현재에는 더미로 처리하였기 때문에 사용하진 않았음
    @State var name: String = ""
    @State var days: String = ""
    @State var memberString: String = ""
    @State var memo: String = ""
    
    @State private var calender = Date()
    
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                // 모달창을 닫기위한 x버튼, action에 dismiss()를 사용해서 x버튼을 누르면 모달창을 닫도록 해줌
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
                .padding(.bottom, 20)
                
                Text("새로운 모임의")
                    .font(.title)
                
                Text("정보를 입력해주세요")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.bottom, 2.0)
                
                Divider()
            }
            .frame(width: 350, alignment: .leading)
            .padding(.bottom,20.0)
            
            VStack(alignment: .leading){
                
                VStack{
                    
                    Text("정산 제목 ")
                        .fontWeight(.bold)
                        .font(.title2)
                    
                    // 유저가 모임 이름을 넣을 수 있는 TextField를 만드는 함수 사용(함수는 아래에서 선언)
                    // 왜 그냥 TextField를 사용하지 않고 굳이 함수를 만들었냐면 여기서 입력된 정보들을 바로바로 매칭되는 CostStore에 저장해주기 위해서 사용
                    DataInput(descript: "모임의 이름을 입력해주세요(최대 10자)", userInput: $name)
                        .padding(.bottom, 30.0)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    
                }
                
                
                HStack{
                    
                    DatePicker(selection: $calender, in: ...Date(), displayedComponents: .date) {
                        Text("날짜")
                            .frame(width: 80, height: 35)
                            .foregroundColor(.white)
                            .background(Color.mainBlue)
                            .cornerRadius(15)
                            .fontWeight(.bold)
                        
                    } .padding(.bottom,20.0)
                    
                    
                    
 
                    //Spacer()
                    // 유저가 날짜를 입력할 수 있는 TextField를 만드는 함수 사용
                    //DataInput(descript: "날짜", userInput: $days)
                }
                
                .padding(.bottom,10.0)
                
                HStack{
                    Text("함께")
                        .frame(width: 80, height: 35)
                        .foregroundColor(.white)
                        .background(Color.mainBlue)
                        .cornerRadius(15)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("총 \(memberString.split(separator: " ").count)명")
                        .fontWeight(.semibold)
                        .font(.title3)
                    
                    
                   
                }
                .padding(.bottom,10.0)
                
                HStack{
                    
                    // 유저가 멤버를 입력할 수 있는 TextField를 만드는 함수 사용
                    DataInput(descript: "이름을 띄어쓰기로 구분하여 입력해주세요", userInput: $memberString)
                        .padding(.leading,10.0)
                    
                    Spacer()
                    
                    // MainView에서와 같이 memberString을 받아서 공백을 기준으로 나누고 갯수를 세어서 몇명인지 출력하기 위해 사용
                    
                    
                }
                .padding(.bottom,10.0)
                
                Text("메모")
                    .frame(width: 80, height: 35)
                    .foregroundColor(.white)
                    .background(Color.mainBlue)
                    .cornerRadius(15)
                    .fontWeight(.bold)
                    .padding(.bottom,10.0)
                
                // 유저가 메모를 입력할 수 있는 TextField를 만드는 함수 사용
                DataInput(descript: "메모해야 할 사항이 있나요? (최대 10자)", userInput: $memo)
                    .padding(.leading, 10.0)
                    .padding(.bottom,30.0)
                
                Spacer()
            }
            // 버튼을 누르면 유저가 입력한 데이터들을 한번에 CostStore에 배열로 추가하기 위해 만든 버튼, 다만 지금은 더미를 사용했음
            Button(action: {
                // addNewTrip()함수를 이용해서 입력된 정보들을 한번에 CostStore로 보내주기위해 사용하려 하였지만 시간 내에 구현하기에는 에러가 발생하여서 우선 주석처리를 해놓은 상태
                // addNewTrip()
                
                // selectedData.costDataCountPlus 함수를 이용해서 costDataCount를 1 증가시킴으로써 '추가된 모임' 더미도 메인화면에서 피커로 선택할 수 있도록 해주려고 사용
                selectedData.costDataCountPlus()
                
                // 모임을 추가하면 자동적으로 모달창이 닫혀서 메인화면으로 넘어가도록 하기위해 사용
                dismiss()
            }, label: {
                Text("입력 완료")
            })
            .frame(width: 350, height: 50)
            .fontWeight(.bold)
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.mainBlue)
            .cornerRadius(15)
            .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal,20.0)
        .padding(.top,30.0)
        
        
    }
    
// 위에서도 말했다 싶이 해당 함수가 유저가 입력한 값들을 한번에 CostStore로 보내는 역할을 하는데 다 정상적으로 작동을 하지만 메인화면 Picker쪽에서 에러가나서 우선은 주석처리를 하고 현재는 더미로만 구현해 놓은 상태
//    func addNewTrip() {
//        let newTrip = Cost(id: UUID().uuidString, name: name, days: days, memberString: memberString, memberArray: [], memo: memo, costArray: [[]])
//
//        costStore.costs.append(newTrip)
//        print(costStore.costs.count)
//        dismiss()
//    }
}

// 유저가 입력한 값들을 해당 인자에 넣기 위해서 정의해놓은 TextField형식의 함수
struct DataInput: View {
    var descript: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            TextField("\(descript)", text: $userInput)
        }
    }
}

struct MainModalView_Previews: PreviewProvider {
    static var previews: some View {
        MainModalView(costStore: CostStore(costs: costData)).environmentObject(SelectedData())
    }
}
