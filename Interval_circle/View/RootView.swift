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
        
        if model.showBoarding {
            OnBoardingView()
        } else {
            switch model.state {
            
            case .setting :
                SettingsView()
            case .prepare:
                PrepareView()
            case .playing :
                CountingView()
            case .interval :
                IntervalView()
                
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
