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
            
            Text("\(model.finishSetCount + 1) セット目")
                .foregroundColor(.white)
                .padding(.vertical, 10)
            
            Text("Do it!")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Spacer()
            
            Progress_CircleView(size : 200,circleColor: Color.green, maxValue: CGFloat(model.time), progress:  $model.counter)
                .onReceive(model.timer) { (_) in
                    print("1111")
                    model.CompleteActive()
                }.padding(10)
               
            
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
