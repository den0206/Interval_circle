//
//  SetView.swift
//  Interval-timer
//
//  Created by 酒井ゆうき on 2020/10/27.
//

import SwiftUI



struct SettingView: View {
    
    @EnvironmentObject var model : IntervalModel
    
    
//    @State private var set = [Int](0...10)
//    @AppStorage("count") var sleepGoal: Double = 0.0

    
    var body: some View {
    
            VStack() {
              Spacer()
                
                Group {
                    Text("稼働時間")
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    Button(action: {}) {
                        
                        Static_Circle(size: 130, circleColor: Color.green, maxValue: 180, progress: $model.selectedCount)
                        
                    }
                }
                .padding(10)
               
                Group {
                    Text("休憩時間")
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    Button(action: {}) {
                        Static_Circle(size: 130, circleColor: Color.red, maxValue: 180, progress: $model.selectedInterval)
                    }
                }
                
                .padding(10)
                
                Spacer()
                
                Button(action: {}) {
                    Text("\(model.selectedSet) セット")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.gray)
                        .clipShape(Capsule())
                    
                }.padding(.top,10)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {}) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,40)
                            .background(Color.green)
                            .clipShape(Capsule())
                        
                    }
                    
                    
                    
                    Button(action: {model.state = .playing}) {
                        Text("スタート")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,40)
                            .background(Color.green)
                            .clipShape(Capsule())
                        
                    }
                    
                    
                    
                }
                .padding(.bottom, 20)
                
               
              
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            .background(Color.black)
            .ignoresSafeArea(.all, edges: .top)
        
        
        
        
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
