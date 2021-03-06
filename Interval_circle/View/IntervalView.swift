//
//  IntervalView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/29.
//

import SwiftUI

struct IntervalView: View {
    
    @EnvironmentObject var model : IntervalModel

    @AppStorage(AppStorageKey.showMovie) var showMovie = true

    var body: some View {
        
        VStack {
            
            Spacer()
            AdBannerView()
                .frame(width: 320, height: 50)
            
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
                        .background(model.isActive ? configureGradient(trailingColor: .blue) : configureGradient(trailingColor: .green))
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    model.showCloseAert(type: .interval)
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(configureGradient(trailingColor: .yellow))
                        .clipShape(Capsule())
                    
                }
              
            }
            .padding(.bottom, 20)
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(showMovie ? AnyView(LooperBackgroundView())  : AnyView(Color.black))
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

