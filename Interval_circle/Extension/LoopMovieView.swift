//
//  LoopMovieView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/31.
//

import SwiftUI
import AVFoundation


struct LoopMoviewView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        return LoopPlayerView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class LoopPlayerView : UIView {
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper : AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iValue = Int.random(in: 1 ... 19)
        
//        guard let path = Bundle.main.path(forResource: "training-\(iValue)", ofType: "mp4") else {
//            print("no path")
//            return
//
//        }
//
//        let fileUrl = URL(fileURLWithPath: path)
        
        guard let fileUrl = Bundle.main.url(forResource: "training-\(iValue)", withExtension: "mp4") else {
            print("no URL")
            return
        }
        
        let item = AVPlayerItem(url: fileUrl)
    
        
        let player = AVQueuePlayer(playerItem: item)
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        player.play()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
