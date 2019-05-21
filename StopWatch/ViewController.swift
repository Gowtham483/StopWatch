//
//  ViewController.swift
//  StopWatch
//
//  Created by gowtham-pt2177 on 10/10/18.
//  Copyright © 2018 gowtham-pt2177. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var TimerField: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var TimerMilli: UILabel!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var hours = 0
    var min = 0
    var sec = 0
    var milli = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PauseButton.isEnabled = false
        StopButton.isEnabled = false
    }

    // MARK: Actions
    
    @IBAction func StartButtonTapped(_ sender: UIButton) {
        if isPlaying {
            return
        }
        StartButton.isEnabled = false
        PauseButton.isEnabled = true
        StopButton.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval : 0.01, target : self, selector : #selector(UpdateTimer), userInfo : nil, repeats : true)
        isPlaying = true
    }
    
    
    @IBAction func PauseButtonTapped(_ sender: UIButton) {
        StartButton.isEnabled = true
        PauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    
    @IBAction func StopButtonTapped(_ sender: UIButton) {
        StartButton.isEnabled = false
        PauseButton.isEnabled = false
        timer.invalidate()
        isPlaying = false
    }
    
    
    @IBAction func ResetButtonTapped(_ sender: UIButton) {
        StartButton.isEnabled = true
        PauseButton.isEnabled = false
        StopButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0
        TimerField.text = "00 : 00 : 00"
        TimerMilli.text = " : 00"
    }
    
    
    @objc func UpdateTimer(timer : Timer) {
        counter = counter + 0.01
        milli = Int(counter * 100) % 100
        if milli == 0 {
            TimerMilli.text = " : 00"
            min = Int(counter) / 60
            hours = min / 60
            sec = Int(counter) % 60
            TimerField.text = "\((hours < 10) ? "0" : "")\(hours) : \((min < 10) ? "0" : "")\(min) : \((sec < 10) ? "0" : "")\(sec)"
        } else {
            TimerMilli.text = " : \((milli < 10) ? "0" : "")\(milli)"
        }
    }
}

