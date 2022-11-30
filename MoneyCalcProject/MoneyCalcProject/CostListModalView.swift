//
//  CostListModalView.swift
//  MoneyCalcProject
//
//  Created by 진준호 on 2022/11/08.
//

import SwiftUI

// 해당 뷰는 제가 데이터를 연결하거나 한 내용이 아예 없기 때문에 모두 UI 레이아웃을 위한 코드입니다... 화이팅!
struct CostListModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var calender = Date()
    @State var string:String=""
    @State var categoryButtonTapped: Bool = false
    @State var personTapped: Bool = false
    
    @State var price:String=""
    
    private var categoryArr: [[String]] = [["house", "숙소"], ["fork.knife", "식비"], ["bag", "쇼핑"], ["car", "교통"], ["checkmark.circle", "체크"], ["checkmark.circle.fill", "헤헷"], ["ellipsis.circle", "기타"]]

    
    var body: some View {
        VStack{
            
            HStack{

                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
                .foregroundColor(.gray)
                .font(.title2)
                
 
                Spacer()
                
                Text("비용추가")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("")
                    
  
            }
            .padding(.horizontal,30.0)
            .padding(.vertical, 10)
            
            
           
            
            ScrollView{
                VStack{
                    
                    VStack{
                        
                        TextField("내용 (필수) ", text: $string )
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            
                        
                        Divider()
                        
                    }
                    .padding(.horizontal,20.0)
                    .padding(10.0)
                    
                    HStack{
                        
                        VStack{
                            
                            Text("KRW")
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                            
                            Text("")
                            Text("")
                            
                        }
                       
                        
                        TextField("금액을 입력해주세요", text: $price)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)

                    }
                    .padding(.horizontal,30.0)
                    .frame(height: 100)
                    .background(Color.mainGray)
                    
                    VStack{
                        
                        VStack{
                         
                            DatePicker(selection: $calender, in: ...Date(), displayedComponents: .date) {
                                Text("날짜를 선택해주세요")
                                    .font(.body)
                                
                            } .padding(.bottom,20.0)
             
                                
                                
                                HStack{
                 
                                    Text("카테고리")
                                        .font(.body)

                                    Spacer()
                                }

                            }
                            .padding(.horizontal,20.0)
                            .padding(10.0)
                        
                        
                        ScrollView(.horizontal) {
                            HStack(spacing:20) {
                                
                                Text("")
                                // 테스트 버튼만 토글로 색깔이 변경됩니다!!!
                                Button {
                                    categoryButtonTapped.toggle()
                                } label: {
                                    VStack {
                                        Image(systemName: "testtube.2")
                                            .font(.system(size: 30))
                                            .padding(.bottom, 5)
                                        Text("Test")
                                    }
                                }
                                .foregroundColor(categoryButtonTapped ? .mainBlue : .gray)

                                
                                ForEach(0..<categoryArr.count, id: \.self) { index in
                                    // key 로 딕셔널 ㅣ정렬
                                    Button {

                                    } label: {
                                        VStack {
                                            Image(systemName: categoryArr[index][0])
                                                .font(.system(size: 30))
                                                .padding(.bottom, 5)
                                            Text(categoryArr[index][1])
                                        }
                                        .padding(5)
                                    }


                                }
//                                categoryDic.forEach { key, value in
//                                    VStack {
//                                        Image(systemName: key)
//                                        Text(value)
//                                    }
//                                }
                            }
                                    
                        }
                        .padding(.horizontal,20.0)
                        .padding(.vertical,10.0)
                        .background(Color.mainGray)
                        .foregroundColor(Color.gray)
                        .padding(.bottom,10.0)
                     
                        
                        VStack{
                            
                            HStack{
                                
                                Text("함께한 사람")
                                    .font(.body)
                                    
                                Spacer()
                                
                                HStack{
                                    
                                    Text("결제")
                                        .padding(.trailing,10.0)
                                        .frame(width: 40)
                                    
                                    Text("함께")
                                        .frame(width: 40)
                                    
                                }
                                .foregroundColor(Color.mainBlue)
                                .font(.body)
                                
                            }
                            
                            VStack{ //함께한 사람 리스트
                                
                                HStack{
                                    
                                    Text("김혜지")
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        // 함께한 사람 Test 버튼
                                        Button {
                                            personTapped.toggle()
                                        } label: {
                                            Image(systemName: "checkmark.circle")
                                                .frame(width: 40)
                                                .foregroundColor(personTapped ? .mainBlue : .gray)
                                        }

                                        
                                        
                                        Image(systemName: "checkmark.circle")
                                            .frame(width: 40)
                                            .foregroundColor(Color.mainBlue)
                                        
                                    }
                                    .font(.title3)
         
                                } .padding(.bottom,5.0)
                                
                                
                                HStack{
                                    
                                    Text("박정선")
                                        .fontWeight(.medium)
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        
                                        Image(systemName: "checkmark.circle")
                                            .frame(width: 40)
                                            .foregroundColor(Color.gray)
                                        
                                        
                                        Image(systemName: "checkmark.circle")
                                            .frame(width: 40)
                                            .foregroundColor(Color.mainBlue)
                                        
                                    }
                                    .font(.title3)

                                    
                                }.padding(.bottom,5.0)
                                
                                HStack{
                                    
                                    Text("전혜성")
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        
                                        Image(systemName: "checkmark.circle")
                                            .frame(width: 40)
                                            .foregroundColor(Color.gray)
                                        
                                        
                                        Image(systemName: "checkmark.circle")
                                            .frame(width: 40)
                                            .foregroundColor(Color.mainBlue)
                                        
                                    }
                                    .font(.title3)

                                    
                                }.padding(.bottom,5.0)
                                
                                
                            }
                            .padding(.leading)
                            .padding(.vertical, 5.0)
                            

                            HStack{
                                    
                                Text("장소")
                                    .font(.body)
                                    
                                TextField("장소를 입력해주세요 (선택) ", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.trailing)
                                    
                                } .padding(.leading,10)
                                .padding(.vertical,10.0)
                                
             
                                
                                
                            HStack{
                 
                                Text("사진")
                                    .font(.body)
                                
                                Spacer()
                            }.padding(.leading,10)
                            
                            HStack{
                 
                                Image(systemName: "photo")
                                    .frame(width: 80, height: 80)
                                    .font(.largeTitle)
                                    .background(Color.mainGray)
                                    .foregroundColor(.gray)
                                    .cornerRadius(15)
                                    .padding(.leading,10.0)

                                Spacer()
                            }
                            
                            Button("비용 추가하기") {
                               
                                
                            }
                            .frame(width: 340, height: 60)
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .background(Color.mainBlue)
                            .cornerRadius(15)
                            .fontWeight(.bold)
                            .padding(.top)
                              
         
                        }
                        .padding(.horizontal,20.0)
                        .padding(10.0)
                       
                        
                    }
                    
                    
                }
                .padding(.horizontal,30.0)
                
            }
        }
    }
}

struct CostListModalView_Previews: PreviewProvider {
    static var previews: some View {
        CostListModalView()
    }
}
