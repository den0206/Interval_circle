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
            
            Text("\(model.finishSetCount) / \(model.selectedSet) Set")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.vertical, 10)
            
            Text("休憩")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Spacer()
            
            Progress_CircleView(size : 200,circleColor: Color.red, maxValue: CGFloat(model.interval), progress:  $model.counter)
                .onReceive(model.intervalTimer) { (_) in
                    model.CompleteInterval()
                }.padding(10)
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    model.stopCounter(type: .interval)
                }) {
                    Text(model.isActive ? "一時停止" : "再開")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(model.isActive ? Color.blue : Color.green)
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    model.showCloseAert(type: .interval)
//                    model.closeCounter(type: .interval)
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.yellow)
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
        .alert(isPresented: $model.showALert, content: {
            model.closeAlert
        })
        .onAppear {
            model.isActive = true
            model.counter = CGFloat(model.interval)
            
        }
        
        
    }
    
}

