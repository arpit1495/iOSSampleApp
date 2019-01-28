//
//  ViewController.swift
//  iOSSampleApp
//
//  Created by Arpit Maheshwari on 25/01/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    
    var targetValue: Int = 0
    
    var score = 0
    
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    //shows alert when hitme button is clicked
    @IBAction func showAlert(){
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        
        let title: String
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        }else if difference < 5{
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        }else if difference < 10{
            title = "Pretty good!"
        }else{
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored: \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //called when slider is moved
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    //called every time a new round starts
    func startNewRound(){
        round += 1
        targetValue = Int(arc4random_uniform(100) + 1)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    //update different labels
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
    //called when start over button is pressed
    @IBAction func startOver(){
        round = 0
        score = 0
        startNewRound()
    }
    
}

