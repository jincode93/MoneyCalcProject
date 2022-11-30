//
//  CostDivideView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

// 해당 뷰도 아직 데이터 연결이 안되어 있기때문에 UI 레이아웃을 위한 코드들입니다...
struct CostDivideView: View {
    
    @ObservedObject var costStore: CostStore = CostStore(costs: costData)
    @EnvironmentObject var selectedData: SelectedData
    
    // 총 비용을 계산하기 편하도록 하기위해 변수로 선언
    @State var sumCost: Int = 0
    @State var sumDivide: Int = 0
    @State var personalCost: [[String]] = [[]]
    @State var dic: [String: Int] = [:]
    
    var body: some View {
        VStack {
            Group() {
                // 선택한 모임의 날짜를 보여줌
                Text("\(costStore.costs[selectedData.selectedIndex].days)")
                    .font(.body)
                
                // 선택한 모임의 이름을 보여줌
                Text("\(costStore.costs[selectedData.selectedIndex].name)")
                    .font(.title2)
                Text("정산내역입니다.")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            // 텍스트를 왼쪽 정렬하기 위해서 width 설정 후 leading
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Divider()
            
            // 정산 결과 제목
            Group {
                HStack {
                    Text("누가 누구에게")
                    Spacer()
                    Text("얼마를")
                }
            }
            .font(.headline)
            .padding(.vertical, 5)
          
            
            Divider()
            
            // 정산 결과 내용
            VStack(spacing: 30) {
                HStack {
                    Text("1.")
                        .foregroundColor(Color.mainBlue)
                    Text("혜성")
                    Text("→")
                    Text("혜지")
                    Spacer()
                    Text("182,750원")
                        .foregroundColor(Color.mainBlue)
                }
                HStack {
                    Text("2.")
                        .foregroundColor(Color.mainBlue)
                    Text("혜성")
                    Text("→")
                    Text("정선")
                    Spacer()
                    Text("3,225원")
                        .foregroundColor(Color.mainBlue)
                }
                
                HStack {
                    Text("3.")
                        .foregroundColor(Color.mainBlue)
                    Text("미지")

                    Text("→")
                    Text("혜지")
                    Spacer()
                    Text("59,775원")
                        .foregroundColor(Color.mainBlue)
                }
                
            }
            .fontWeight(.medium)
            .padding(.vertical, 20)
            
            Divider()
            
            // 개인별 지출금액 제목
            Group {
                HStack {
                    Text("개인별 지출금액")
                    Spacer()
                }
                .font(.headline)
                .fontWeight(.medium)
                .padding(.vertical, 10)
            }
            Divider()
            
            ScrollView {
                ForEach(costStore.costs[selectedData.selectedIndex].memberArray, id: \.self) { i in
                    // 개인별 지출금액 목록
                    VStack(spacing: 30) {
                        HStack(spacing: 3) {
                            Image("Zero")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50, alignment: .leading)
                                .padding(.trailing)
                            Text(" \(i) ")
                                .font(.body)
                                .fontWeight(.medium)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(sumDivide)원")
                                    .fontWeight(.semibold)
                                Text("결제 \(dic[i] ?? 0 )원")
                                    .foregroundColor(.gray)
                                    .font(.callout)
                                //                        Text("\(총액)원")
                            }
                        }
                    }
                    
                }
                .padding(.vertical, 25)
            }
            
            Spacer()
        }
        .padding(30)
        .onAppear{
            sumCost = costStore.costs[selectedData.selectedIndex].costArray.flatMap { $0 }.compactMap { str in Int(str) }.reduce(0, +)
            
            personalCost = costStore.costs[selectedData.selectedIndex].costArray
            
            
            let members = costStore.costs[selectedData.selectedIndex].memberArray
            
            sumDivide = Int(sumCost/members.count)
            for member in members {
                
                var sum = 0
                for i in personalCost {
                    if i[3].contains(member) {
                        sum += Int(i[1])!
                    }
                }
                dic[member] = sum
            }
            
            //            print(dic)
        }
    }
}


struct CostDivideView_Previews: PreviewProvider {
    static var previews: some View {
        CostDivideView().environmentObject(SelectedData())
    }
}
