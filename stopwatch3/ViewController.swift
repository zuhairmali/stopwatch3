//
//  ViewController.swift
//  stopwatch3
//
//  Created by Student on 12/16/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var backgroundColors: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var lightOn = true 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func lightOn(_ sender: UIButton) {
        lightOn = !lightOn
        if lightOn {
            view.backgroundColor = .red
        }
        else {
            view.backgroundColor = .white
        }
    }
    @IBAction func startStopButtonTapped(_ sender: Any) {
        
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Timer", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("Start", for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
