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

enum TimerType {
    case count
    case interval
}

class IntervalModel : ObservableObject {
    
    
    
    @Published var state : ViewState = .setting
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var isActive = false
    
    @Published var counter : CGFloat = 0.0
    @Published var finishSetCount = 0
    
    @Published var selectedCount : CGFloat = 0
    @Published var selectedInterval : CGFloat = 0
    @Published var selectedSet = 1
    
    @Published var showALert = false
    @Published var closeAlert = Alert(title: Text(""))
    
    let maxValue : CGFloat = 180
    
    var time : Int {
        return Int(round(selectedCount * maxValue))
        
    }
    
    var interval : Int {
        Int(round(selectedInterval * maxValue))
    }
    
    //MARK: - functions
    
    func CompleteActive() {
        
        switch counter {
        
        case 1,2,3 :
            print("Sounds")
            counter -= 1

        case 0 :
            finishSetCount += 1
            
            if finishSetCount == selectedSet {
                print("Finish")
                timer.upstream.connect().cancel()
                finishSetCount = 0
                state = .setting
            } else {
                counter = CGFloat(interval)
                timer.upstream.connect().cancel()
                intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                state = .interval
                
                
            }
        default :
            counter -= 1
        }
        
        
        
       
//        if counter == 0 {
//
//            finishSetCount += 1
//            if finishSetCount == selectedSet {
//                print("Finish")
//                timer.upstream.connect().cancel()
//                finishSetCount = 0
//                state = .setting
//            } else {
//                counter = CGFloat(interval)
//                timer.upstream.connect().cancel()
//                intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//                state = .interval
//
//
//            }
//        }
//
//        counter -= 1
    }
    
    func CompleteInterval() {
        
        switch counter {
        
        case 1,2,3 :
            print("Sounds")
            counter -= 1
           
        case 0 :
            counter = CGFloat(time)
            intervalTimer.upstream.connect().cancel()
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            state = .playing
        default :
            counter -= 1
        }
        
      
        
//        if counter == 0 {
//            counter = CGFloat(time)
//            intervalTimer.upstream.connect().cancel()
//            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//            state = .playing
//
//        }
//
//        counter -= 1
    }
    
    
    /// common func
    
    func stopCounter(type : TimerType) {
        
        switch type {
        
        case .count:
            
            if isActive {
                timer.upstream.connect().cancel()
            } else {
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
        case .interval:
            
            if isActive {
                intervalTimer.upstream.connect().cancel()
            } else {
                intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
        }
      
        isActive.toggle()
    }
    
    
    func showCloseAert(type : TimerType) {
        
       
        if type == .count {
            stopCounter(type: .count)
            closeAlert = Alert(title: Text("終了しますか？"), message: nil, primaryButton: .cancel(Text("再開する"), action: {
                self.stopCounter(type: .count)
            }), secondaryButton: .destructive(Text("終了する"), action: {
                self.closeCounter(type: .count)
            }))
        } else {
            stopCounter(type: .interval)
            closeAlert = Alert(title: Text("終了しますか？"), message: nil, primaryButton: .cancel(Text("再開する"), action: {
                self.stopCounter(type: .interval)
            }) , secondaryButton: .destructive(Text("終了する"), action: {
                self.closeCounter(type: .interval)
            }))
        }
        
        showALert = true
    }
    
    
    func closeCounter(type : TimerType) {
        if type == .count {
            timer.upstream.connect().cancel()
        } else {
            intervalTimer.upstream.connect().cancel()
        }
        
        finishSetCount = 0
        state = .setting
    }
    
    
   
    
}

