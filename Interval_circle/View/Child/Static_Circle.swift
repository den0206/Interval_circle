//
//  Static_Circle.swift
//  Interval-timer
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

struct Static_Circle: View {
    
    var size : CGFloat
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
            
            /// cente Text
            
            Text( String(format: "%.0f", progress) + "秒")
                .font(.body)
                .foregroundColor(.white)
        }
    }
}

