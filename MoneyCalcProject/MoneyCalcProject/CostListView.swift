//
//  CostListView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

struct CostListView: View {
    @ObservedObject var costStore: CostStore = CostStore(costs: costData)
    @EnvironmentObject var selectedData: SelectedData
    
    // 해당 창에도 비용 추가하기를 누르면 모달창이 열려야하기 때문에 정의
    @State private var isShowingSheet2 = false
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                HStack {
                    // 선택된 모임의 이름을 출력
                    Text("\(costStore.costs[selectedData.selectedIndex].name)")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                    EditButton()
                        .frame(width: 50, height: 30)
                        
                        
                }
                .padding(.vertical,10.0)
                .padding(.horizontal,10.0)
                .background(Color.white)
                
                Divider()
                
            }
            
            .padding(.horizontal)
            //.frame(width: UIScreen.main.bounds.width, height: 100)
            .background(Color.white)
            
            // 만약에 금액을 사용한 데이터가 없다면 텅 빈 화면을 나타내주어야 하는데 그냥 공백으로 나두면 이상하니깐 이모지와 아이 깨끗해!를 출력하도록 해서 UI 개선
            if costStore.costs[selectedData.selectedIndex].costArray.isEmpty {
                Spacer()
                Image(systemName: "hands.sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, .yellow)
                    .padding(.bottom)
                
                Text("아이 깨끗해!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                
                // 금액을 사용한 데이터가 하나라도 있다면 아래 코드가 작동해서 List로 보여주도록 함
            } else {
                HStack {
                    // 날짜별로 분류하기 위한 Picker를 만드려고 하였으나 시간부족으로 인해 더미를 이용
                    Picker("아직 정산한 모임이 없어요 ><", selection: .constant(1)) {
                        Text("날짜별")
                        Text("day1")
                        Text("day2")
                        Text("day3")
                    }
                    
                    
                    Picker("아직 정산한 모임이 없어요 ><", selection: .constant(1)) {
                        Text("카테고리별")
                        Text("카테고리1")
                        Text("카테고리2")
                        Text("카테고리3")
                    }
                    
                    .cornerRadius(10)
                    
                    // 모달창을 열기 위한 버튼
                    Button(action: {
                        isShowingSheet2.toggle()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 130, height: 36)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white))
                                .padding(10)
                                
                            Text("비용 추가하기")
                                .foregroundColor(Color.mainBlue)
                                .fontWeight(.bold)
                                .font(.headline)
                            
                        }
                    })
                }.background(Color.white)
                    .frame( height: 40)
                
                
                
               
                
                // 비용 목록이 있는 경우 리스트와 총액을 보여준다
                List {
                    // json파일에 가보면 1일차, 2일차 등으로 날짜를 구별해 놓았는데 날짜별로 Section이 나누어져서 원하지 않는 날짜의 소비 내역은 접어서 안볼 수 있도록 하기위해 날짜별로 Section을 나눔
                    // 잘보면 아래에 들어간 costArrayView 뒤에 숫자가 있는데 시간이 부족하다보니 로직으로 구성을 하지 않고 각 뷰마다 해당 날짜만 출력할 수 있도록 로직을 구성해놓고 그걸 여러개 복사해서 사용하였음(View1은 1일차, View2는 2일차 이런식으로)
                    Section("day1") {
                        ForEach(costStore.costs[selectedData.selectedIndex].costArray, id: \.self) {
                            costArrayView1(arr: $0)
                        }
                        .font(.body)
                        .padding(10.0)
                    }
                    Section("day2") {
                        ForEach(costStore.costs[selectedData.selectedIndex].costArray, id: \.self) {
                            costArrayView2(arr: $0)
                        }
                        .font(.body)
                        .padding(10.0)
                    }
                    Section("day3") {
                        ForEach(costStore.costs[selectedData.selectedIndex].costArray, id: \.self) {
                            costArrayView3(arr: $0)
                        }
                        .font(.body)
                        .padding(10.0)
                    }
                    Section("day4") {
                        ForEach(costStore.costs[selectedData.selectedIndex].costArray, id: \.self) {
                            costArrayView4(arr: $0)
                        }
                        .font(.body)
                        .padding(10.0)
                    }
                }
                .listStyle(.plain)
                
                // 총 금액을 구하는 방법인데 현재 선택된 모임이 가지고 있는 2차배열인 costArray에서 금액만 뽑아서 사용하기로 함
                // flatMap을 사용해서 2차배열을 1차배열로 만들어주도록 하였고, compactMap을 사용해서 안에 내용들 중 Int로 바꾸었을 때 남아있는 값(예를 들어 String 형태이긴 하지만 "2000"과 같이 "안에는 Int값이 있는 항목들)만 뽑아서 해당 값들을 reduce를 이용해서 다 더해서 총 금액을 구함
                Text("총 금액 : \(costStore.costs[selectedData.selectedIndex].costArray.flatMap { $0 }.compactMap { str in Int(str) }.reduce(0, +))원")
                   
                    .fontWeight(.semibold)
                    .font(.title2).frame(width: UIScreen.main.bounds.width, height: 70)
                    .background(Color.white)
                    .shadow(color: .gray.opacity(0.2), radius: 5)
                    
                    
                    
            }

        }
        // 흰색 여백이 조금씩 있는게 보기 싫어서 정의해줌
        .background(Color.white)
        // 비용 추가하기 버튼을 누르면 costListModalSheetView가 모달창으로 나오도록 해줌
        .fullScreenCover(isPresented: $isShowingSheet2, content: CostListModalSheetView.init)
    }
    // 모달창을 닫기 위한 함수 다만 여기서는 특별한 닫기 조건이 필요없기 때문에 빈 함수로 놔둠
    func didDismiss2() {
    }
    
    // 리스트들을 밀어서, 또는 Edit버튼을 이용해서 삭제하기위해서 만들었으나 현재 작동되진 않음, 리스트들이 함수를 이용해서 뽑아서 사용하다보니 조금 더 복잡한 로직이 필요
    private func deleteItem(indexSet: IndexSet) {
        
    }
    // 리스트들을 Edit버튼을 이용해서 편집하기위해서 만들었으나 현재 작동되진 않음, 리스트들이 함수를 이용해서 뽑아서 사용하다보니 조금 더 복잡한 로직이 필요
    private func moveItem(from source: IndexSet, to destination: Int) {
        
    }
    
}

// CostListModaView를 가져오기 위해서 정의한 구조체
struct CostListModalSheetView: View {
    var body: some View {
        CostListModalView()
    }
}

// 1일차 항목들만 뽑아서 사용하기 위해 정의한 구조체
// 안에 있는 내용은 모두 동일하기 때문에 1일차에만 주석을 달아놓음
struct costArrayView1: View {
    
    // emoji를 앞에 달아주기 위해서 선언
    @State private var emoji: String = ""
    // 카테고리를 나타내기 위해 선언
    var cate: String = ""
    // 금액을 나타내기 위해 선언
    var cost: String = ""
    // 날짜별로 판별하기 위해 선언
    var day: String = ""
    
    // 초기화를 통해서 값을 받아옴
    // 이렇게 정의한 이유가 costArray는 2차배열로 되어있는데 안에 있는 1차 배열은 카테고리, 비용, 날짜로 이루어져 있음
    // forEach에서 이 1차 배열들을 통째로 하나씩 받아오기 때문에 이것들을 나누어서 원하는 위치에 배치를 해서 보여주도록 해주기 위해서 이러한 방식으로 사용
    init(arr: [String]) {
        self.cate = arr[0]
        self.cost = arr[1]
        self.day = arr[2]
    }
    
    var body: some View {
        
        // 만약 받아온 1차 매열에서 3번째 항목이 1일차이면 나머지 값들을 리스트로 보여주도록 하기 위해 if 조건문 사용
        if day == "1일차" {
            HStack {
                // 1일차가 맞다면 emoji를 표기해주고 카테고리 이름을 출력 시킴
                Text("\(emojiMatch(cate: cate)) \(cate)")
                Spacer()
                // 오른쪽에 금액이 원 단위로 나오도록 해줌
                Text("\(cost) 원")
            }
        }
    }
    
    // emojiMatch 함수를 만들어서 cate변수에 있는 카테고리에 따라서 이모지를 return 해주도록 함
    func emojiMatch(cate: String) -> String {
        if cate == "식비" {
            return "🍽️  "
        } else if cate == "숙소" {
            return "🏨  "
        } else if cate == "쇼핑" {
            return "🛍️  "
        } else if cate == "교통" {
            return "🚃  "
        } else if cate == "관광" {
            return "🕌  "
        } else {
            return "🎸  "
        }
    }
}

// 2일차 항목들만 뽑아서 사용하기 위해 정의한 구조체
struct costArrayView2: View {
    
    @State private var emoji: String = ""
    var cate: String = ""
    var cost: String = ""
    var day: String = ""
    
    init(arr: [String]) {
        self.cate = arr[0]
        self.cost = arr[1]
        self.day = arr[2]
    }
    
    var body: some View {
        
        if day == "2일차" {
            HStack {
                Text("\(emojiMatch(cate: cate)) \(cate)")
                Spacer()
                Text("\(cost) 원")
            }
        }
    }
    
    func emojiMatch(cate: String) -> String {
        if cate == "식비" {
            return "🍽️  "
        } else if cate == "숙소" {
            return "🏨  "
        } else if cate == "쇼핑" {
            return "🛍️  "
        } else if cate == "교통" {
            return "🚃  "
        } else if cate == "관광" {
            return "🕌  "
        } else {
            return "🎸  "
        }
    }
}

// 3일차 항목들만 뽑아서 사용하기 위해 정의한 구조체
struct costArrayView3: View {
    
    @State private var emoji: String = ""
    var cate: String = ""
    var cost: String = ""
    var day: String = ""
    
    init(arr: [String]) {
        self.cate = arr[0]
        self.cost = arr[1]
        self.day = arr[2]
    }
    
    var body: some View {
        
        if day == "3일차" {
            HStack {
                Text("\(emojiMatch(cate: cate)) \(cate)")
                Spacer()
                Text("\(cost) 원")
            }
        }
    }
    
    func emojiMatch(cate: String) -> String {
        if cate == "식비" {
            return "🍽️  "
        } else if cate == "숙소" {
            return "🏨  "
        } else if cate == "쇼핑" {
            return "🛍️  "
        } else if cate == "교통" {
            return "🚃  "
        } else if cate == "관광" {
            return "🕌  "
        } else {
            return "🎸  "
        }
    }
}

// 4일차 항목들만 뽑아서 사용하기 위해 정의한 구조체
struct costArrayView4: View {
    
    @State private var emoji: String = ""
    var cate: String = ""
    var cost: String = ""
    var day: String = ""
    
    init(arr: [String]) {
        self.cate = arr[0]
        self.cost = arr[1]
        self.day = arr[2]
    }
    
    var body: some View {
        
        if day == "4일차" {
            HStack {
                Text("\(emojiMatch(cate: cate)) \(cate)")
                Spacer()
                Text("\(cost) 원")
            }
        }
    }
    
    func emojiMatch(cate: String) -> String {
        if cate == "식비" {
            return "🍽️  "
        } else if cate == "숙소" {
            return "🏨  "
        } else if cate == "쇼핑" {
            return "🛍️  "
        } else if cate == "교통" {
            return "🚃  "
        } else if cate == "관광" {
            return "🕌  "
        } else {

            return "🎸  "

        }
    }
    
}


struct CostListView_Previews: PreviewProvider {
    static var previews: some View {
        CostListView().environmentObject(SelectedData())
    }
}
