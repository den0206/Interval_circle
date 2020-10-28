//
//  Circular_Slider.swift
//  Interval-timer
//
//  Created by 酒井ゆうき on 2020/10/27.
//

import SwiftUI

struct Circular_Slider: View {
    
    var size : CGFloat = UIScreen.main.bounds.width - 100
    var circleColor : Color
    var maxValue : CGFloat
    
    
    @Binding var progress : CGFloat
    @Binding var angle : Double

    var body: some View {
        
        ZStack {
            /// base Circle
            Circle().stroke(Color.gray, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
            
       
            
            /// Progress CIrcle
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to:progress)
                .stroke(circleColor, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
                .rotationEffect(.init(degrees: -90))
            
//            Circle()
//                .fill(Color.black)
//                .frame(width: 55, height: 155)
//                .offset(x: size / 2)
//                .rotationEffect(.init(degrees: -90))
            
            /// drag Circle
            Circle()
                .fill(Color.white)
                .frame(width: 55, height: 155)
                .offset(x: size / 2)
                .rotationEffect(.init(degrees: angle))
                .gesture(DragGesture().onChanged(onDrag(value:)))
                .rotationEffect(.init(degrees: -90))
            
            /// cente Text
            
            Text( String(format: "%.0f", progress * maxValue) + "秒")
                .font(.body)
                .foregroundColor(.white)
        }
      
    }
    
    func onDrag(value : DragGesture.Value) {
        
       
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radius = atan2(vector.dy - 27.5, vector.dx - 27.5)
        
        var angle = radius * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
        }
        
    }
}

