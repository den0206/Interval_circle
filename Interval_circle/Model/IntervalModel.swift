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
    case prepare
    case playing
    case interval
    
}

class IntervalModel : ObservableObject {
    
    @Published var state : ViewState = .setting
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    @Published var isActive = false
    
    @Published var counter : CGFloat = 0.0
    @Published var dutarion : CGFloat = 0.1
    
    @Published var finishSetCount = 0
    @Published var storedDuration: CGFloat = 0.1
    
    
    @Published var selectedCount : CGFloat = 0
    @Published var selectedInterval : CGFloat = 0
    @Published var selectedSet = 1
    
    let maxValue : CGFloat = 180
    
    var time : Int {
        return Int(round(selectedCount * maxValue))
        
    }
    
    var interval : Int {
        Int(round(selectedInterval * maxValue))
    }
    
    //MARK: - functions
    
    func CompleteActive() {
        
        counter -= 1
        print(counter)
        if counter == 0 {
            
            finishSetCount += 1
            if finishSetCount == selectedSet {
                print("Finish")
                timer.upstream.connect().cancel()
                state = .setting
            } else {
                
                state = .interval
                counter = CGFloat(interval)
                timer.upstream.connect().cancel()

            
            }
         
        }
    }
    
    func stopCounter() {
        if isActive {
            timer.upstream.connect().cancel()
        } else {
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        
        isActive.toggle()
    }
    
    
    func closeCounter() {
        timer.upstream.connect().cancel()
        finishSetCount = 0
        state = .setting
    }
    
    func CompleteInterval() {
        
        counter -= 1
        
        if counter == 0 {
            
            
            state = .playing
            counter = CGFloat(time)
        
        }
    }
    
    
}

