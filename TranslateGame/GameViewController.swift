//
//  GameViewController.swift
//  TranslateGame
//
//  Created by Victor Sundberg on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    let wordPairs = [
            ["hej": "hello"],
            ["tack": "thank you"],
            ["ja": "yes"],
            ["nej": "no"],
            ["adjö": "goodbye"],
            ["god morgon": "good morning"],
            ["kvinna": "woman"],
            ["man": "man"],
            ["hus": "house"],
            ["bil": "car"],
            ["katt": "cat"],
            ["hund": "dog"],
            ["vatten": "water"],
            ["bok": "book"],
            ["mat": "food"],
            ["bröd": "bread"],
            ["mjölk": "milk"],
            ["äta": "eat"],
            ["dricka": "drink"],
            ["springa": "run"],
            ["gå": "walk"],
            ["sova": "sleep"]
        ]
    
    var currentScore = 0
    var time = 60
    var timer: Timer?
    var currentWordPair:[String:String] = [:]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGame()
        // Do any additional setup after loading the view.
    }
    
    func startGame(){
        
        randomizeWord()
        
    }
    
    func randomizeWord(){
        
        if let randomPair = wordPairs.randomElement(){
            currentWordPair = randomPair
            
            if let swedishWord = currentWordPair.keys.first {
                currentWordLabel.text = swedishWord
            }
        }
    }
    
    func checkAnswer(_ translation:String) -> Bool {
        if let correctAnswer = currentWordPair.values.first?.lowercased(){
            return correctAnswer.lowercased() == correctAnswer
        }
        return false
    }
    
    
    
    
    
    @IBAction func enterButton(_ sender: UIButton) {
        
        guard let translation = answerTextField.text, !translation.isEmpty else { return }
        
        if checkAnswer(translation){
            currentScore += 1
            scoreLabel.text = "Score: \(currentScore)"
            
            randomizeWord()
        } else {
//            shakeTextField()
        }
        
        answerTextField.text = ""
        
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        }
    
}
