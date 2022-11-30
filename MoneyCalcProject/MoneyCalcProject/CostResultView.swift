//
//  CostResultView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI
import Charts

struct CostResultView: View {
    
    @ObservedObject var costStore: CostStore = CostStore(costs: costData)
    @EnvironmentObject var selectedData: SelectedData
    
    // 총액을 다른 곳에 계산할 일이 있을 때 나타내기 쉽도록 변수로 선언하였음
    // 해당 화면이 onAppear될 때 총액을 받아오도록 아래에 코드를 넣어둠
    @State var sumCost: Int = 0
    
    // 카테고리 항목에 따라서 퍼센테이지 수치를 계산해서 넣어둘 변수 선언, 다만 현재에는 더미 역할을 함
    @State var perCate: [Int] = [0, 0, 0, 0, 0, 0]
    
    var body: some View {
        VStack {
            Group {
                // 선택한 모임의 날짜를 출력
                Text("\(costStore.costs[selectedData.selectedIndex].days)")
                    .font(.body)

                // 선택한 모임의 이름을 출력
                Text("\(costStore.costs[selectedData.selectedIndex].name)")
                    .font(.title2)
                Text("지출 내역입니다.")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            // 텍스트를 왼쪽 정렬하기 위해서 width 설정 후 leading
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title)
            
            Divider()
            
            Group {
                HStack {
                    Text("총 지출 금액")
                    Spacer()
                }
            }
            .font(.headline)
            .padding(.vertical, 10)
            
            
            Divider()
            
            VStack(spacing: 30) {
                HStack{
                    // 총 금액 출력
                    Text("\(sumCost)")
                        .foregroundColor(Color.mainBlue)
                    Text("원")
                    Spacer()
                }
                .font(.title)
            }
            .fontWeight(.semibold)
            .padding(.vertical, 25)
            
            Divider()
            
            Group {
                HStack {
                    // 가장 높은 비율을 차지하는 값을 넣으려 하였으나 시간 문제로 현재 더미상태
                    Text("뫄뫄에서 가장 많이 썼어요.")
                    Spacer()
                }
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
            }
            Divider()
            
            HStack {
                VStack {
                    VStack {
                        
                        // 각 항목의 이름과 이모티콘, 해당 항목의 값들의 합을 나타냄
                        // 지금보니 다 포크와 나이프로 되어있군요... 항목에 맞게 변경 부탁드립니다~!
                        // 아래 각각에 있는 내용들도 모두 동일하기 때문에 제일 위에만 주석을 달겠습니다...
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("숙소")
                                .fontWeight(.semibold)
                        }
                        // calcCate라는 함수를 사용해서 뒤에 넣은 카테코리에 해당하는 금액들이 다 더해져서 숫자로 나오도록 함
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "숙소")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("식비")
                                .fontWeight(.semibold)
                        }
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "식비")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("쇼핑")
                                .fontWeight(.semibold)
                        }
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "쇼핑")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("교통")
                                .fontWeight(.semibold)
                        }
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "교통")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("관광")
                                .fontWeight(.semibold)
                        }
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "관광")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color.mainBlue)
                            Text("기타")
                                .fontWeight(.semibold)
                        }
                        Text("\(calcCate(costStore.costs[selectedData.selectedIndex].costArray, "기타")) 원")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 10)
                }
                
                // 차트를 유동적으로 표현하기 위해서 Chart를 사용
                Chart {
                    // 차트의 그래프를 나타내기 위한 인자들
                    BarMark(
                        // 가로 그래프를 그리기 위해서 x축에 사용빈도(원래는 사용비율을 넣으려 하였는데 갑자기 생각이 안나서 그냥 사용빈도로 적음), perCate[0]에 있는 Int 값을 불러와서 그만큼 뻗어나간 그래프를 그려줌
                        x: .value("사용빈도", perCate[0]),
                        // 세로는 항목을 넣어주면 되서 이렇게 넣었는데 "숙소"자리에 String값으로 해당 퍼센테이지 수치를 넣어주면 현재 차트에 조그만하게 숙소라고 적혀있는 부분을 26%, 30% 이런 식으로 나타낼 수 있을 것임
                        y: .value("항목", "숙소")
                    )
                    BarMark(
                        x: .value("사용빈도", perCate[1]),
                        y: .value("항목", "식비")
                    )
                    BarMark(
                        x: .value("사용빈도", perCate[2]),
                        y: .value("항목", "쇼핑")
                    )
                    BarMark(
                        x: .value("사용빈도", perCate[3]),
                        y: .value("항목", "교통")
                    )
                    BarMark(
                        x: .value("사용빈도", perCate[4]),
                        y: .value("항목", "관광")
                    )
                    BarMark(
                        x: .value("사용빈도", perCate[5]),
                        y: .value("항목", "기타")
                    )
                }
                // 값이 변경되며 애니메이션 효과를 넣어서 차트가 변하는 모습을 나타내주기 위해 사용
                .animation(.easeOut(duration: 1), value: perCate)
                .frame(height: 320)
            }
            .padding(.vertical, 25)
            //            Spacer()
        }
        .padding(30)
        .onAppear{
            // 해당 화면을 열면 sumCost(총 금액)이 계산되어서 나타내지도록 정의
            sumCost = costStore.costs[selectedData.selectedIndex].costArray.flatMap { $0 }.compactMap { str in Int(str) }.reduce(0, +)
            // 해당 화면을 열면 각 항목이 총 금액에서 몇퍼센트 되는지 유동적으로 바뀌게 하고 싶어서 처음에 시작을 하였으나 시간부족으로 더미로 대체하여야 했기 때문에 json의 각 항목에 perArray를 넣어서 퍼센트를 넣고 해당 화면이 나타날 때 선택한 모임이 바뀌었다면 해당 내용들도 다 바뀌도록 해서 애니메이션 연출
            perCate = costStore.costs[selectedData.selectedIndex].perArray
        }
    }
    
    // 항목별 금액을 계산하기 위한 함수
    // 매개변수에 costArray와 원하는 항목을 입력하면 costArray에서 항목을 찾아서 금액만 계산하여서 return하도록 만듬
    func calcCate(_ costArray: [[String]], _ cate: String) -> Int {
        
        // 여기서 sum은 항목별 계산된 총금액을 말함
        var sum: Int = 0
        
        for i in costArray {
            if i[0] == cate {
                sum += Int(i[1]) ?? 0
            }
        }
        
        return sum
    }
}



struct CostResultView_Previews: PreviewProvider {
    static var previews: some View {
        CostResultView().environmentObject(SelectedData())
    }
}
