//
//  Interval_circleApp.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI
import GoogleMobileAds

@main
struct Interval_circleApp: App {

    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }

    @StateObject var model = IntervalModel()
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .environmentObject(model)
        }
    }
}
