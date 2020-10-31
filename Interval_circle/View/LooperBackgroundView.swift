//
//  LooperBackgroundView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/31.
//

import SwiftUI

struct LooperBackgroundView: View {
    var body: some View {
        
        LoopMoviewView()
            .overlay(Color.black.opacity(0.5))
            .blur(radius: 1)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct LooperBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LooperBackgroundView()
    }
}
