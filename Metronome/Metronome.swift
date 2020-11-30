//
//  Metronome.swift
//  Metronome
//
//  Created by Rais on 04/03/20.
//  Copyright © 2020 Rais. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Metronome {
    
    var bpm: Double = 60.0 { didSet {
        bpm = min(300.0,max(30.0,bpm))
    }}
        
    
    var enabled: Bool = false { didSet {
        if enabled {
            start()
        } else {
            stop()
        }
    }}
    
    func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)

        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)

        var position : CGPoint = view.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        view.layer.position = position;
        view.layer.anchorPoint = anchorPoint;
    }
    
    var onTick: ((_ nextTick: DispatchTime) -> Void)?
    var nextTick: DispatchTime = DispatchTime.distantFuture
    
    let audioPlayer : AVAudioPlayer = {
        do {
            let sound = Bundle.main.path(forResource: "tick", ofType: ".mp3")
            let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            return audioPlayer
        } catch {
            print("Error: \(error)")
            return AVAudioPlayer()
        }
    }()
    
    func start() {
        nextTick = DispatchTime.now()
        audioPlayer.prepareToPlay()
        nextTick = DispatchTime.now()
        tick()
    }
    
    func stop() {
        audioPlayer.stop()
    }
    
    func tick() {
        guard enabled, nextTick <= DispatchTime.now()
            else { return }
        
        let interval : TimeInterval = 60.0 / TimeInterval(bpm)
        nextTick = nextTick + interval
        DispatchQueue.main.asyncAfter(deadline: nextTick) {[weak self] in
            self?.tick()
        }
        
        audioPlayer.play()
        onTick?(nextTick)
    }
    
}
