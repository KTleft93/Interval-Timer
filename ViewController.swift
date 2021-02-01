//
//  ViewController.swift
//  Work Timer
//
//  Created by apple on 4/10/20.
//  Copyright © 2020 Kean Nwaziri. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    var workRunning2 = false
    var workRunning = false
    var restRunning = false
    var resumeTapped = false
    var roundsReset = 0
    var secondsReset = 0
    var restReset = 0
    var stopW = false
    var stopR = false
    var roundsRemaining = 1
    var roundsRemainingSaved = 0
    var secondsRemainingSaved = 0
    var restSecondsRemainingSaved = 0
    var restSecondsRemaining = 1
    var secondsRemaining = 1
    var timer: Timer?
    var timer1: Timer?
    var soundEnabled = true
    var audioPlayer: AVAudioPlayer?
    var audioPlayer1: AVAudioPlayer?
    @IBOutlet weak var stopActive: UIButton!
    @IBOutlet weak var stopRestDisplay: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var soundStateLabel: UILabel!
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var restCountdownLabel: UILabel!
    
    @IBOutlet weak var roundsCountdown: UILabel!
    
    func hideResume(){
         resumeButton.isHidden=true
    }
    
    
    
    @IBAction func soundSwitchTapped(_ sender: Any) {
        if soundEnabled {
        soundEnabled = false
        soundStateLabel.text = "Enable Sound"
        } else {
        soundEnabled = true
        soundStateLabel.text = "Disable Sound"
        }
    }
    @IBAction func timerButtonTapped(_ sender: Any) {
        // hide button and picker//
        
        roundLabel.isHidden=true
        roundsCountdown.isHidden=true
        workLabel.isHidden = true
        timerButton.isHidden = true
        picker1.isHidden = true
        picker2.isHidden = true
        picker.isHidden = true
        restLabel.isHidden = true
        stopActive.isHidden=false
        
        // set countdown label text to seconds remaining and unhide it
        roundsRemainingSaved=roundsRemaining;
        restSecondsRemainingSaved=restSecondsRemaining;
        secondsRemainingSaved=secondsRemaining;
        
   roundsReset=roundsRemainingSaved;
  secondsReset=secondsRemainingSaved;
        restReset=restSecondsRemainingSaved;
        
    // self.performSegue(withIdentifier: "Test", sender: self)
        
        countdownLabel.isHidden = false
       // countdownLabel.text = String(secondsRemaining)
                // start the timer
        runTimer()
        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
        
    }
    @objc func runTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementSaved), userInfo: nil, repeats: true)
        
    }
    
    @objc func runTimer2(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementRestTimeSaved), userInfo: nil, repeats: true)
        
    }

    @objc func decrementSaved(){
        
        
        countdownLabel.text = String(secondsRemainingSaved)
        
        stopActive.isHidden=false
        workRunning=true
        countdownLabel.isHidden=false
        secondsRemainingSaved -= 1
        
       // secondsRemainingSaved -= 1
        
           countdownLabel.text = String(secondsRemainingSaved)
           
               if secondsRemainingSaved == 0 {
           // unschedule timer and reset seconds remaining
                secondsRemainingSaved=secondsReset;
                countdownLabel.isHidden=true
                
           timer?.invalidate()
               // countdownLabel.isHidden=true
                stopActive.isHidden=true
                
                runTimer2()
                
                if soundEnabled == true{
                // play sound
                audioPlayer1?.play()
                } else {
                // vibrate
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
        
        }}
    @objc func decrementRestTimeSaved(){
       
        stopRestDisplay.isHidden=false
        restRunning=true
         restSecondsRemainingSaved -= 1
        restCountdownLabel.isHidden=false
        
        
       // restSecondsRemainingSaved -= 1
        restCountdownLabel.text=String(restSecondsRemainingSaved)
       
        if restSecondsRemainingSaved == 0{
           
            
            restSecondsRemainingSaved=restReset;
            timer?.invalidate();
            restCountdownLabel.isHidden=true
            stopRestDisplay.isHidden=true
            
            if soundEnabled == true{
                              // play sound
                              audioPlayer?.play()
                              }
                              
                              else {
                              // vibrate
                              AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                              }
          
            if roundsRemainingSaved > 0 {
               
                roundsRemainingSaved -= 1
                          roundsCountdown.text=String(roundsRemainingSaved)
               
                if roundsRemainingSaved == 0{
                                   self.performSegue(withIdentifier: "Test", sender: self)
                     timer?.invalidate();
                    
                    if soundEnabled == true{
                    // play sound
                    audioPlayer?.play()
                    }
                    
                    else {
                    // vibrate
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                    
                               }
                
                
                if secondsRemainingSaved > 0 && roundsRemainingSaved > 0{
                           
                    runTimer()
                            //  timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementSaved), userInfo: nil, repeats: false)
                    if soundEnabled == true{
                    // play sound
                    audioPlayer?.play()
                    }
                    
                    else {
                    // vibrate
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                          }
            }
            
        }
        
    }*********

   
    
    @objc func decrementRounds(){
            
        roundsRemaining -= 1
        
           }
    
    

   @IBAction func stopWork(_ sender: Any) {
    
    timer?.invalidate()
    resumeButton.isHidden=false
    stopW=true
         
     }
     @IBAction func stopRest(_ sender: Any) {
        
        timer?.invalidate()
        resumeButton.isHidden=false
        stopR=true
        
     }
     
    
    @IBAction func resume(_ sender: Any) {
        
        //resumeButton.isHidden=true
        // is only checking 1st condition need to differentiate 
        if stopW == true{
          
            workRunning=false
            stopW=false
            resumeButton.isHidden=true
            runTimer()
        
            
        }
        else if stopR == true {
            
            restRunning=false
            stopR=false
            resumeButton.isHidden=true
            runTimer2()
        }
    
            else{
                   timer?.invalidate()
        }
    }
   
        
    
    
    
    @IBOutlet weak var timerButton: UIButton!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0{
            return 60
        }
        else if pickerView.tag == 1{
               return 60
        }
        else{
        return 30
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(row + 1)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        if pickerView == picker1{
    secondsRemaining = row + 1
        }
            else if pickerView == picker{
          restSecondsRemaining = row + 1
            }
            else{
        roundsRemaining = row + 1
            }
   // roundsRemaining = row + 1
    }
    
    
    override func viewDidLoad() {
        
        picker.tag=0
        picker2.tag=2
        picker1.tag=1
        stopActive.isHidden=true
        stopRestDisplay.isHidden=true
        
        hideResume()
    
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "bell", ofType: "wav")!)
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer?.prepareToPlay()
        
        let alertSound1 = URL(fileURLWithPath: Bundle.main.path(forResource: "ding bell", ofType: "wav")!)
               try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
               try! AVAudioSession.sharedInstance().setActive(true)
               try! audioPlayer1 = AVAudioPlayer(contentsOf: alertSound1)
               audioPlayer1?.prepareToPlay()
               
       
    }


}

