//
//  CountdownModel.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//


import Foundation
import AVFoundation
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
    
    
    @Published var showBoarding = true
    @Published var state : ViewState = .setting
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var isActive = false
    
    @Published var counter : CGFloat = 0.0
    @Published var finishSetCount = 0
    @Published var showSetCount = true

    
    @Published var selectedCount : CGFloat = 0
    @Published var selectedInterval : CGFloat = 0
    @Published var selectedSet = 1
    
    @Published var showALert = false
    @Published var closeAlert = Alert(title: Text(""))
    
    
    /// sounds
    var startsound1 : AVAudioPlayer?
    var startsound2 : AVAudioPlayer?
    var startsound3 : AVAudioPlayer?

    var finishsound : AVAudioPlayer?
    
    let maxValue : CGFloat = 180
    
    var time : Int {
        return Int(round(selectedCount * maxValue))
        
    }
    
    init() {
        /// prepare sounds
        preparrSound()
    }
    
    var interval : Int {
        Int(round(selectedInterval * maxValue))
    }
    
    //MARK: - functions
    
    func CompleteActive() {
    
        if counter > 0 {
            counter -= 1
        }
        
        
        switch counter {
        
        case 10 :
            playStart3Sound()
        
        case 1,3:
            playStart1Sound()
            
        case 2 :
            playStart2Sound()
 
        case 0 :
            finishSetCount += 1
            showSetCount = false
        
            playFinishSound()
            
            if finishSetCount == selectedSet {
                timer.upstream.connect().cancel()
                finishSetCount = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.state = .setting
                }
                
            } else {
                
                self.timer.upstream.connect().cancel()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                    self.state = .interval
                    self.counter = CGFloat(self.interval)
                    self.intervalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

                }
             
            }
            
        default :
            break
        }
    
    }
    
    func CompleteInterval() {
        
        if counter > 0 {
            counter -= 1

        } else {
            print("Call")
            return
        }
        
        switch counter {

        
        case 1,3:
            playStart1Sound()
        case 2 :
            
            playStart2Sound()
 
        case 0 :
            
            showSetCount = true
            playFinishSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               
                self.intervalTimer.upstream.connect().cancel()
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                self.state = .playing
                self.counter = CGFloat(self.time)
            }

           
        default :
            break
        }

    }
    
    func prepareAction() {
        playFinishSound()
        timer.upstream.connect().cancel()
        Thread.sleep(forTimeInterval: 0.5)
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        state = .playing
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
    
    
    //MARK: - sounds
    
    func preparrSound() {
        if let path = Bundle.main.path(forResource: "start-sound", ofType: "mp3") {
            do {
                startsound1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                
                startsound1?.prepareToPlay()
            } catch {
                print("No Sound")
            }
        }
        
        if let path = Bundle.main.path(forResource: "start-sound", ofType: "mp3") {
            do {
                startsound2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                
                startsound2?.prepareToPlay()
            } catch {
                print("No Sound")
            }
        }
        
        if let path = Bundle.main.path(forResource: "boxing2", ofType: "mp3") {
            do {
                startsound3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                
                startsound3?.prepareToPlay()
            } catch {
                print("No Sound")
            }
        }
        
        if let path = Bundle.main.path(forResource: "finish-sound", ofType: "mp3") {
            do {
                finishsound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                
                finishsound?.prepareToPlay()
            } catch {
                print("No Sound")
            }
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        
        
        print("prepare OK")
    }
    
    func playStart1Sound() {
        
        DispatchQueue.global().async {
            self.startsound1?.play()
        }
       
        
    }
    
    func playStart2Sound() {
        DispatchQueue.global().async {
            self.startsound2?.play()
        }
        
    }
    func playStart3Sound() {
        DispatchQueue.global().async {
            self.startsound3?.play()
        }
        
    }
    
    func playFinishSound() {
        
        DispatchQueue.global().async {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            self.finishsound?.play()
        }
    }
 
}

