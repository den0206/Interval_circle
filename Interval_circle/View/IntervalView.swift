//
//  IntervalView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/29.
//

import SwiftUI

struct IntervalView: View {
    
    @EnvironmentObject var model : IntervalModel

    var body: some View {
        
        VStack {
            Spacer()
            
            Text("\(model.finishSetCount ) セット目")
                .foregroundColor(.white)
                .padding(.vertical, 10)
            
            Text("休憩")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Spacer()
            
            Progress_CircleView(size : 200,circleColor: Color.red, maxValue: CGFloat(model.interval), progress:  $model.counter)
                .onReceive(model.timer) { (_) in
                    print("22222")
                    model.CompleteInterval()
                }.padding(10)
                .onAppear{print("Circle")}
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    model.stopCounter()
                }) {
                    Text(model.isActive ? "一時停止" : "再開")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(model.isActive ? Color.blue : Color.green)
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    model.closeCounter()
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.green)
                        .clipShape(Capsule())
                    
                }
              
            }
            .padding(.bottom, 20)
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            model.isActive = true
            model.counter = CGFloat(model.interval)
            
        }
        
        
    }
    
}

