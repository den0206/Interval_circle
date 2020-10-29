//
//  Progress_CircleView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/29.
//

import SwiftUI

struct Progress_CircleView: View {
    var size : CGFloat = UIScreen.main.bounds.width - 100
    var circleColor : Color
    var maxValue : CGFloat
    
    @Binding var progress : CGFloat

    var body: some View {
        
        ZStack {
            /// base Circle
            Circle().stroke(Color.gray, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
            
       
            
            /// Progress CIrcle
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to:progress / maxValue)
                .stroke(circleColor, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
                .rotationEffect(.init(degrees: -90))
                .animation(.spring())
            

            /// cente Text
            
            Text( String(format: "%.0f", progress ) + "秒")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
      
    }
}
