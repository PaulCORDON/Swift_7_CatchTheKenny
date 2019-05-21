//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by MAC-DIN-002 on 21/05/2019.
//  Copyright © 2019 MAC-DIN-002. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    
    /*Array of UIImageView*/
    var kennyArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*check highscore*/
        /*retrieve the highscore*/
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        /*if there isn't highscore, highscore = 0*/
        if highScore == nil {
            highscoreLabel.text = "0"
        }
        /*else we put the highscore value on screen*/
        if let newScore = highScore as? Int {
            highscoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = "Score : \(score)"
        
        /*add gerture recognizer to the images*/
        let regognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let regognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        
        kenny1.addGestureRecognizer(regognizer1)
        kenny2.addGestureRecognizer(regognizer2)
        kenny3.addGestureRecognizer(regognizer3)
        kenny4.addGestureRecognizer(regognizer4)
        kenny5.addGestureRecognizer(regognizer5)
        kenny6.addGestureRecognizer(regognizer6)
        kenny7.addGestureRecognizer(regognizer7)
        kenny8.addGestureRecognizer(regognizer8)
        kenny9.addGestureRecognizer(regognizer9)
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        /*creating timer*/
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        /*creating arrays*/
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        hideKenny()
        
        
        
    }
    
    @objc func increaseScores() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    
    }
    
    @objc func countDown(){
        counter = counter-1
        timeLabel.text = "\(counter)"
        
        if(counter == 0){
            timer.invalidate()
            hideTimer.invalidate()
            
            /*checking highscore*/
            
            if self.score > Int(highscoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highscoreLabel.text = String(self.score)
            }
            
            
            /*alert creation*/
            let alert = UIAlertController(title: "Time", message: "Your time is up !", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.score = 0
                self.counter = 30
                self.scoreLabel.text = "Score : \(self.score)"
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
                
                
            })
                
            alert.addAction(ok)
            alert.addAction(replay)
            self.present(alert,animated: true,completion: nil)
            
        }
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        /*create a ramdom number between 0 and the kenny array size*/
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        
        kennyArray[randomNumber].isHidden = false
    }
    

}

