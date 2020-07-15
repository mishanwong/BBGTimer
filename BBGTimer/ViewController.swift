//
//  ViewController.swift
//  BBGTimer
//
//  Created by Mishan Wong on 7/7/20.
//  Copyright © 2020 Mishan Wong. All rights reserved.

import UIKit
import Foundation

class ViewController: UIViewController {
    var ourTimer = Timer()
    var timeRemaining:Int = 1800
    var sound = SoundManager()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var roundCounter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //Define function to convert Int to timeString
    func timeString(time: Int) -> String {
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
    
    //Define roundNumbers and timeRemaining display
    let round1 = Array(1381...1800) // 1381 - 1800
    let break1 = Array(1351...1380) // 1351 - 1380
    let round2 = Array(931...1350) // 931 - 1350
    let break2 = Array(901...930) // 901 - 930
    let round3 = Array(481...900) // 481 - 900
    let break3 = Array(451...480) // 451 - 480
    let round4 = Array(31...450) // 31 - 450
    let break4 = Array(1...30) // 1 - 30
    
    
    @objc func fireTimer() {
        timeRemaining -= 1
        
        if timeRemaining == 0 {
            ourTimer.invalidate()
        }
                
        if round1.contains(timeRemaining) {
            roundCounter.text = String("Round 1")
            timerLabel.text = String(timeString(time: timeRemaining - 23*60))
        }

        if round2.contains(timeRemaining) {
            roundCounter.text = String("Round 2")
            timerLabel.text = String(timeString(time: timeRemaining - 15*60 - 30))

        }

        if round3.contains(timeRemaining) {
            roundCounter.text = String("Round 3")
            timerLabel.text = String(timeString(time: timeRemaining - 8*60))

        }

        if round4.contains(timeRemaining) {
            roundCounter.text = String("Round 4")
            timerLabel.text = String(timeString(time: timeRemaining - 30))

        }
        
        if break1.contains(timeRemaining) {
            roundCounter.text = String("Break 1")
            timerLabel.text = String(timeString(time: timeRemaining - 22*60 - 30))

        }

        if break2.contains(timeRemaining) {
            roundCounter.text = String("Break 2")
            timerLabel.text = String(timeString(time: timeRemaining - 15*60))

        }

        if break3.contains(timeRemaining) {
            roundCounter.text = String("Break 3")
            timerLabel.text = String(timeString(time: timeRemaining - 7*60 - 30))

        }

        if break4.contains(timeRemaining) {
            roundCounter.text = String("Break 4")
            timerLabel.text = String(timeString(time: timeRemaining))

        }
        
        //Sound effects
        if timeRemaining == 1799 { sound.playSound(effect: .round1) }
        if timeRemaining == 1350 { sound.playSound(effect: .round2) }
        if timeRemaining == 900 { sound.playSound(effect: .round3) }
        if timeRemaining == 480 { sound.playSound(effect: .round4) }
        if timeRemaining == 1380 || timeRemaining == 930 || timeRemaining == 480 || timeRemaining == 30 { sound.playSound(effect: .takeBreak) }
        if timeRemaining == 0 { sound.playSound(effect: .complete) }
    
    
    }
        
    @IBAction func startTapped(_ sender: Any) {
        
        //Prevent screen from going to sleep when timer is running
        UIApplication.shared.isIdleTimerDisabled = true
        
        ourTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        }
    
    
    @IBAction func pauseTapped(_ sender: Any) {
        ourTimer.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false

        
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        timeRemaining = 1800
        timerLabel.text = String("07:00")
        roundCounter.text = String("Round 1")
        ourTimer.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false
        
    }
}
