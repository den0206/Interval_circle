//
//  RootView.swift
//  Interval-timer
//
//  Created by 酒井ゆうき on 2020/10/27.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var model : IntervalModel
    
    var body: some View {
        
        switch model.state {
        
        case .setting :
            SettingsView()
        case .prapare:
            Text("prepare")
        case .playing :
            Text("Playing")
        case .interval :
            Text("Interval")
    
       
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
