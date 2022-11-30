//
//  MainView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI


// 원하는 컬러를 사용하기 위해 Assets에 컬러를 지정해주고 extension으로 설정해줌
extension Color{
    static let mainBlue = Color("mainBlue")
    static let listColor = Color("listColor")
    static let mainGray = Color("mainGray")
}


struct MainView: View {

    // 새로운 모임 추가하기 버튼을 눌렀을 때 상태를 변화시켜 모달창을 띄우기 위해서 사용
    @State private var isShowingSheet = false
    
    // costStore의 경우 그냥 읽어오기만 하면 되기 때문에 ObservedObject를 사용
    @ObservedObject var costStore: CostStore = CostStore(costs: costData)
    
    // SelectedData 파일 안에 selectedIndex에 접근해서 값을 변경해주기 위해 EnvironmentObject를 사용
    @EnvironmentObject var selectedData: SelectedData
    
    var body: some View {
        VStack{
                // 배경색상을 지정해줌
                
                VStack{
                    
                    ZStack{
                        Color.mainBlue.edgesIgnoringSafeArea(.all)

                        ZStack{

                            //타이틀
                            VStack(alignment: .leading, spacing: 0.0){
                                Text("안녕하세요.")
                                    .font(.title)
                                    
                                
                                Text("정산하러 오셨군요!")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .padding(.bottom, 10.0)
                                
                                Text("모임을 선택해주세요. 없다면, 새로운 모임을 추가해주세요")
                                    .font(.callout)
                                    .fontWeight(.bold)
                            }
                            .padding(.leading)
                            .foregroundColor(.white)
                            .padding(.top, 50.0)

                        }
                        
                        // Picker를 이용해서 저장된 모임들을 선택할 수 있도록 하였고, selection에 선택한 값을 다른 페이지로도 보내주기 위해서 selectedData에 접근해서 selectedIndex를 사용 (이렇게 해야지 피커에서 모임을 변경하더라도 다른 페이지도 변경된 모임의 자료들을 보여줄 수 있음)
                        Picker("아직 정산한 모임이 없어요 ><", selection: $selectedData.selectedIndex) {
                            // 현재 더미의 갯수가 4개인데 처음에는 '추가된 모임'을 제외하고 처음에는 3개만 보여줘야되서 selectedData에 있는 costDataCount를 연결
                            ForEach(0..<selectedData.costDataCount, id: \.self) {
                                // costStore에 저장되어 있는 더미의 name을 불러와서 모임 이름을 나타내게 해줌
                                Text(costStore.costs[$0].name)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(width:350, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top,250.0)
                        .padding(.bottom,-20.0)

                    }
                    
                    VStack{
                        
                        //카드
                        VStack{
                            // selectedData.selectedIndex를 costStore에 있는 costs 배열의 인덱스로 사용하여서 현재 선택된 모임의 이름을 출력
                            Text("\(costStore.costs[selectedData.selectedIndex].name)")
                                .font(.title)
                                .fontWeight(.bold)
                                
                            
                            Divider()
        
                            VStack(alignment: .leading){
                                HStack{
                                    Text("날짜")
                                        .frame(width: 80, height: 35)
                                        .foregroundColor(.white)
                                        .background(Color.mainBlue)
                                        .cornerRadius(15)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    // selectedData.selectedIndex를 costStore에 있는 costs 배열의 인덱스로 사용하여서 현재 선택된 모임의 날짜를 출력
                                    Text("\(costStore.costs[selectedData.selectedIndex].days)")
                                        .frame(width: 200, height: 35, alignment: .trailing)
                                        .fontWeight(.medium)
                                }

                                HStack(alignment: .center){
                                    
                                    Text("함께")
                                        .frame(width: 80, height: 35)
                                        .foregroundColor(.white)
                                        .background(Color.mainBlue)
                                        .cornerRadius(15)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    // selectedData.selectedIndex를 costStore에 있는 costs 배열의 인덱스로 사용하여서 현재 선택된 모임의 멤버를 출력
                                    Text("\(costStore.costs[selectedData.selectedIndex].memberString)") .frame(width: 200, height: 35, alignment: .trailing)
                                        .fontWeight(.medium)
                                }
                                
                                
                                HStack{
                                    
                                    Text("")
                                    
                                    Spacer()
                                    
                                    // selectedData.selectedIndex를 costStore에 있는 costs 배열의 인덱스로 사용하여서 현재 선택된 모임의 멤버를 불러오고 split을 사용해서 공백을 기준으로 분리한 후 갯수를 세어서 몇명인지 출력되도록 함
                                    Text("총 \(costStore.costs[selectedData.selectedIndex].memberString.split(separator: " ").count)명")
                                        .frame(width: 290.0,alignment: .trailing)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                    
                                    

                                    
                                }
                                HStack{
                                    
                                    Text("메모")
                                        .frame(width: 80, height: 35)
                                        .foregroundColor(.white)
                                        .background(Color.mainBlue)
                                        .cornerRadius(15)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("")
                                    
                                    Spacer()
                                    
                                }
                                .padding(.bottom,15.0)
                                // selectedData.selectedIndex를 costStore에 있는 costs 배열의 인덱스로 사용하여서 현재 선택된 모임의 메모를 출력
                                Text("\(costStore.costs[selectedData.selectedIndex].memo)")
                                    .padding(.leading, 10.0)
                                    .padding(.bottom,15.0)
                            }.padding(.top,20.0)
                            
                            Button("새로운 모임 추가하기") {
                                isShowingSheet.toggle()
                            }
            
                            .frame(width: 350, height: 50)
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.mainBlue)
                            .background(Color.mainGray)
                            .cornerRadius(15)
                            .fontWeight(.bold)
                            .padding(.bottom,25.0)
                            
                        }
                        .padding(.horizontal, 15.0)
                        
                       
                        
                      
                        
                        
                        
                    }.frame(width: 350, height: 460)
                    
                    
                   
                    
                    
                    
                    
                    // 버튼 action에 isShowingSheet.toggle을 넣어서 버튼을 누르면 isShowingSheet의 상태를 true로 변환시켜줘서 모달창을 나타나게 함
                   
                    
                    
                }
            
        }
        // .sheet를 사용해서 isShowingSheet의 상태가 true가 되면 MainModalSheetView()를 나타나게 함
        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
            MainModalSheetView()
        }
    }
    // 모달창을 없애기 위한 함수(따로 조건에 따라서 사용할 일이 없기때문에 안이 빈 상태로 놔둠)
    func didDismiss() {
    }
}

// MainModalView를 받아오는 역할을 하는 MainModalSheetView를 선언한 구조체
struct MainModalSheetView: View {
    var body: some View {
        MainModalView(costStore: CostStore(costs: costData))

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(SelectedData())
    }
}
