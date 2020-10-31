//
//  PrepareView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI
import AVFoundation

struct PrepareView: View {

    @EnvironmentObject var model : IntervalModel
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage(AppStorageKey.showMovie) var showMovie = true

    @State private var counter = 3
    
    var body: some View {
        
        ZStack {
            /// Z1
            VStack(alignment: .trailing) {
                
                HStack() {
                    
                    Spacer()
                    
                    VStack {
                        Toggle("", isOn: $showMovie)
                            .labelsHidden()
                        Text(showMovie ? "No Movie" : "動画表示")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                .padding()
              
                Spacer()
            }
            .padding(.top, 13)
            
            /// Z2
            VStack {
                
                HStack {
                    Button(action: {
                        model.closeCounter(type: .count)
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
                    .offset(y: -80)
                    .onReceive(model.timer) { (_) in
        
                        counter -= 1
                        
                        if counter == 0 {
                            
                            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

                            model.playFinishSound()
                            model.timer.upstream.connect().cancel()
                            Thread.sleep(forTimeInterval: 0.5)
                            model.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            model.state = .playing
                        }
                      
                    }
                
                Spacer()
                
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(showMovie ? AnyView(LooperBackgroundView())  : AnyView(Color.black))
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct PrepareView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareView()
    }
}
