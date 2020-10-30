//
//  CountingView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/29.
//

import SwiftUI

struct CountingView: View {
    
    @EnvironmentObject var model : IntervalModel
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("\(model.finishSetCount + 1) / \(model.selectedSet) Set")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.vertical, 10)
            
            Text("Do it!")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Spacer()
            
            Progress_CircleView(size : 200,circleColor: Color.green, maxValue: CGFloat(model.time), progress:  $model.counter)
                .onReceive(model.timer) { (_) in
                    model.CompleteActive()
                }.padding(10)
               
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    
                    model.stopCounter(type: .count)
                }) {
                    Text(model.isActive ? "一時停止" : "再開")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(model.isActive ? Color.blue : Color.green)
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    model.showCloseAert(type: .count)
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.red)
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
            model.counter = CGFloat(model.time)
            
        }
       
    }
}

struct CountingView_Previews: PreviewProvider {
    static var previews: some View {
        CountingView()
    }
}
