//
//  Sound.swift
//  GoD
//
//  Created by kai chen on 2020/3/9.
//  Copyright © 2020 Chen. All rights reserved.
//
import SpriteKit
import AVFoundation

class Sound: NSObject {
    static var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    static var ap2:AVAudioPlayer = AVAudioPlayer()
    static func play(_ fileName: String) {
//        return
//        if audioPlayer.isPlaying {
//            audioPlayer.stop()
//        }
        if !Game.instance.playSound {
            return
        }
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
                    
            let path = Bundle.main.path(forResource: fileName, ofType: "mp3")
            let soudUrl = URL(fileURLWithPath: path!)
            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.75
            audioPlayer.numberOfLoops = -1
            
            audioPlayer.play()
        } catch {
            print("video file \(fileName) play failed!")
            print(error)
        }
    }
    static func stop() {
//        return
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    static func dialog() {
        Sound.play(node: Game.instance.curStage, fileName: "dialog")
    }
    static func close() {
        Sound.play(node: Game.instance.curStage, fileName: "close")
    }
//    static func play(node:SKNode, fileName:String) {
//        if !Game.instance.playEffect {
//            return
//        }
//        let action = SKAction.playSoundFileNamed("\(fileName).mp3", waitForCompletion: false)
//        node.run(action)
//    }
    static func play(node:SKNode, fileName: String) {
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setActive(true)
                try session.setCategory(AVAudioSession.Category.playback)
                UIApplication.shared.beginReceivingRemoteControlEvents()
                        
                let path = Bundle.main.path(forResource: fileName, ofType: "mp3")
                let soudUrl = URL(fileURLWithPath: path!)
                try ap2 = AVAudioPlayer(contentsOf: soudUrl)
                ap2.prepareToPlay()
                ap2.volume = 1.0
                if ap2.isPlaying {
                    ap2.stop()
                }
                ap2.numberOfLoops = 0
                
                ap2.play()
            } catch {
                print("video file \(fileName) play failed!")
                print(error)
            }
        }
}
