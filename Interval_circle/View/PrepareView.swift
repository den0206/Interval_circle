//
//  PrepareView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

struct PrepareView: View {

    @EnvironmentObject var model : IntervalModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var counter = 3
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button(action: {
                    model.closeCounter()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                })
                .padding()
               
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("\(counter)")
                .font(.system(size: 150, weight: .black, design: .default))
                .offset(y: -20)
                .onReceive(model.timer) { (_) in
    
                    counter -= 1
                    
                    if counter == 0 {
                        Thread.sleep(forTimeInterval: 0.5)
                        model.state = .playing
                    }
                  
                }
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct PrepareView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareView()
    }
}
