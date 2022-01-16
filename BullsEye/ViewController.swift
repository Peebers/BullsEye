//
//  ViewController.swift
//  BullsEye
//
//  Created by Samantha Smith on 1/13/22.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }

    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        var title: String
        if difference == 0 {
            title = "Perfect!\n100 bonus points!"
            points += 100
        } else if difference < 5 {
            title = "So close!"
            if difference == 1 {
                points += 50
                title += "\n50 bonus points!"
            }
            else {
                points += 25
                title += "\n25 bonus points!"
            }
        } else if difference < 10 {
            title = "Good guess!\n10 bonus points!"
            points += 10
        } else {
            title = "You can do better!"
        }
        score += points
        
        let message = "You scored \(points) points!"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in self.startNewRound()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
        
    }
    
    @IBAction func startNewGame(){
        round = 0
        score = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
}

