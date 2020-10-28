//
//  SettingsView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var model : IntervalModel
    
    @AppStorage(AppStorageKey.timer) var timerStorage = 0
    @AppStorage(AppStorageKey.interval) var intervalStorage  = 0
    @AppStorage(AppStorageKey.set) var setStorage  = 0
    
    @State var timerAngle : Double = 0
    @State var intervalAngle : Double = 0
    
    let maxValue : CGFloat = 180
    
    var body: some View {
        VStack() {
          Spacer()
            
            Group {
                Text("稼働時間")
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                Circular_Slider(size: 130, circleColor: Color.green, maxValue: maxValue, progress: $model.selectedCount, angle: $timerAngle)
               
            }
            .padding(10)
           
            Group {
                Text("休憩時間")
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                Circular_Slider(size: 130, circleColor: Color.red, maxValue: maxValue, progress: $model.selectedInterval, angle: $intervalAngle)
            }
            
            .padding(10)
            
            Spacer()
            
            Button(action: {
                print("Set")
            }) {
                Text("\(model.selectedSet) セット")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,40)
                    .background(Color.gray)
                    .clipShape(Capsule())
                
            }.padding(.top,10)
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    saveStorage()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.yellow)
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
        .onAppear {
            self.model.selectedCount = CGFloat(timerStorage) / maxValue
            self.model.selectedInterval =  CGFloat(intervalStorage) / maxValue
            self.model.selectedSet = setStorage
            
            self.timerAngle = Double(self.model.selectedCount * 360)
            self.intervalAngle = Double(self.model.selectedInterval * 360)
        }
        
    }
    
    private func saveStorage() {
        
        print(model.selectedInterval * 180)
        timerStorage = Int(round(model.selectedCount * maxValue))
        intervalStorage = Int(round(model.selectedInterval * maxValue))
        setStorage = model.selectedSet
        
        print(timerStorage, intervalStorage)
    }
}

