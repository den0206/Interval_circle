//
//  Interval_circleApp.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

@main
struct Interval_circleApp: App {
    
    @StateObject var model = IntervalModel()
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .environmentObject(model)
        }
    }
}
