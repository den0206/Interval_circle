//
//  CountingView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/29.
//

import SwiftUI

struct CountingView: View {
    
    @EnvironmentObject var model : IntervalModel
    
    @AppStorage(AppStorageKey.showMovie) var showMovie = true

    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            AdBannerView()
                .frame(width: 320, height: 50)
            
            Spacer()
            
            
            Text(model.finishSetCount + 1 != model.selectedSet ? "\(model.finishSetCount + 1) / \(model.selectedSet) Set" : "Last Set!")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.vertical, 10)
                .opacity(model.showSetCount ? 1 : 0)
            
  
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
                        .background(model.isActive ? configureGradient(trailingColor: .blue) : configureGradient(trailingColor: .green))
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    model.showCloseAert(type: .count)
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(configureGradient(trailingColor: .red))
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

//        .background(Color.black)
        .alert(isPresented: $model.showALert, content: {
            model.closeAlert
        })
        .onAppear {
            
            model.isActive = true
            model.showSetCount = true
            model.counter = CGFloat(model.time)
            
        }
       
    }
}

struct CountingView_Previews: PreviewProvider {
    static var previews: some View {
        CountingView()
    }
}
