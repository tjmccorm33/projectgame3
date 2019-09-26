//
//  ViewController.swift
//  projectgame-0
//
//  Created by Tyler j McCormick on 9/21/19.
//  Copyright © 2019 mccormick-labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var currentScore = 0 {
        didSet {
            scoreLabel.text = "Score: \(self.currentScore)"
        }
    }
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        countries += ["estonia",
                      "france",
                      "germany",
                      "ireland",
                      "italy",
                      "monaco",
                      "nigeria",
                      "poland",
                      "russia",
                      "spain",
                      "uk",
                      "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor(red:1.0, green: 0.2, blue: 0.3, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = "\(countries[correctAnswer].uppercased()) Score: \(currentScore)"
    }
        

    func handleChoice(wasCorrect: Bool) {
        var responseMessage: String
        
        if wasCorrect {
            title = "Correct!"
            responseMessage = "You just gained 1 point."
            currentScore += 1
        } else {
            title = "Incorrect!"
            responseMessage = "You just lost 1 point."
            currentScore = max(0, currentScore - 1)
        }
        
        let alertController = UIAlertController(title: title, message: responseMessage, preferredStyle: .alert)
        
        alertController.addAction(
            UIAlertAction(title: "Continue", style: .default, handler: _askAnotherQuestion)
        )
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    
         if sender.tag == correctAnswer {
            handleChoice(wasCorrect: true)
        } else {
            handleChoice(wasCorrect: false)
        }
    }
    
    func _askAnotherQuestion(action: UIAlertAction) {
        askQuestion()
    }
}

