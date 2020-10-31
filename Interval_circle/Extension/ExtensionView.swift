//
//  ExtensionView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/30.
//

import SwiftUI

extension View {
    
    
    func showHUD(isShowing : Binding<Bool>, _ text : Text = Text("成功しました！")) -> some View {
        HUDView(isShowing: isShowing, presenting: {
            self
        }, text: text)
    }
}



func configureGradient(leadingColor : Color = .clear, trailingColor : Color) -> LinearGradient {
    
    return LinearGradient(gradient: Gradient(colors: [leadingColor, trailingColor]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
}


struct HUDView<Presenting> : View where Presenting : View {
    
    @Binding var  isShowing : Bool
    let presenting : () -> Presenting
    let text : Text
    
    var body: some View {
        
        if self.isShowing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation() {
                    self.isShowing = false
                }
            }
        }
        
        return GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                self.presenting()
//                    .blur(radius: self.isShowing ? 1 : 0)
                
//
                /// black back
                if self.isShowing {

                    Color.black.opacity(0.4)
                        .ignoresSafeArea(.all)
                }

                
                VStack {
                    self.text
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
                
            }
            
        }
        
        
    }
    
}
