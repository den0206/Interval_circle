//
//  CountdownModel.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//


import Foundation
import SwiftUI

enum ViewState {
    
    case setting
    case prapare
    case playing
    case interval
    
}

class IntervalModel : ObservableObject {
    
    @Published var state : ViewState = .setting
    
    @Published var counter : CGFloat = 0.0
    @Published var dutarion : CGFloat = 0.1
    
    @Published var storedDuration: CGFloat = 0.1
    
    
    @Published var selectedCount : CGFloat = 0
    @Published var selectedInterval : CGFloat = 0
    @Published var selectedSet = 1
}

