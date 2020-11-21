//
//  AdMob.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/11/21.
//

import SwiftUI
import GoogleMobileAds

struct AdBannerView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        
        banner.adUnitID = testMode ? adMobKey.testKey : adMobKey.banner1
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        
        return banner
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
