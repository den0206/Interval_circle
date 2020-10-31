//
//  SetListView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

struct SetListView: View {
    
    var action : (_ i: Int)-> Void
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(AppStorageKey.showMovie) var showMovie = true

    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                HStack {
                    
                    Spacer()
                    
                    
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    })
                   
                }
                .padding()
                
                ScrollView {
                    ForEach(1...20, id : \.self) { i in
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.action(i)
                        }) {
                            VStack {
                                
                                HStack {
                                    Text("\(i) セット")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                 
                                }
                                
                                Divider()
                                    .background(Color.white)
                            }
                        }
                       

                    }
                }
               
                Spacer()
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(showMovie ? AnyView(LooperBackgroundView())  : AnyView(Color.black))
        }
        
        
    }
}


