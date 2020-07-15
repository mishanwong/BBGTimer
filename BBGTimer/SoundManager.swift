//
//  SoundManager.swift
//  BBGTimer
//
//  Created by Mishan Wong on 7/14/20.
//  Copyright © 2020 Mishan Wong. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    //Create a property to hold the object
    var audioPlayer:AVAudioPlayer?
    
    //Create an enum data type that can be one of these 3 values
    enum SoundEffect {
        case start
        case round1
        case round2
        case round3
        case round4
        case takeBreak
        case complete
    }
    
    
    //Create a method that we can call to play sound
    func playSound(effect:SoundEffect) {
        var soundFileName = ""
        
        switch effect {
            case .start:
                    soundFileName = "start"
            case .round1:
                    soundFileName = "round1"
            case .round2:
                    soundFileName = "round2"
            case .round3:
                    soundFileName = "round3"
            case .round4:
                    soundFileName = "round4"
            case .takeBreak:
                    soundFileName = "break"
            case .complete:
                    soundFileName = "commplete"
        }
        
        //Get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".m4a")
        
        //Make sure bundle path is not equals to nil
        guard bundlePath != nil else {
            //Couldn't find the resource, exit
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        //Catch the error if any
        do {
            //Create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            //Play the sound effect
            audioPlayer?.play()
        }
        catch {
            print("Couldn't create an audio player")
            return
        }
    }
    
}
