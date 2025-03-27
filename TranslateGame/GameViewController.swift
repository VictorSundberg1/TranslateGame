//
//  GameViewController.swift
//  TranslateGame
//
//  Created by Victor Sundberg on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
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
    var time : Double = 10
    var timer: Timer?
    var currentWordPair:[String:String] = [:]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        answerTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startGame()
    }
    
    
    func startGame(){
        
        timer?.invalidate()
        time = 10
        currentScore = 0
        scoreLabel.text = "Score: \(currentScore)"
        randomizeWord()
        startTimer()
    }
    
    
    func startTimer(){
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true ) { [weak self] _ in
        guard let self = self else { return }
            
            self.time -= 0.1
            
            self.timerLabel.text = "Time : \(Int(self.time))"
            
            if self.time <= 0 {
                endGame()
            }
                        
        }
    }
    
    
    func endGame(){
        timer?.invalidate()
        
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(currentScore)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"Play again", style: .destructive, handler: { _ in self.dismiss(animated: true)}))
        
        alert.addAction(UIAlertAction(title: "High score", style: .default, handler: {_ in self.showHighscore()}))
        
        
        present(alert, animated: true)
    }
    
    func showHighscore (){
        performSegue(withIdentifier: "showHighScore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHighScore"{
            
           if let destinationVC = segue.destination as? HighScoreViewController {
               destinationVC.highScore = currentScore
           }
            
         
        }
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
            return translation.lowercased() == correctAnswer
        }
        return false
    }
    
    
    
    
    
    @IBAction func enterButton(_ sender: Any) {
        
        guard let translation = answerTextField.text, !translation.isEmpty else { return }
        
        print(translation)
        
        if checkAnswer(translation){
            currentScore += 1
            scoreLabel.text = "Score: \(currentScore)"
            
            randomizeWord()
        } else {
           shakeTextField()
        }
        
        answerTextField.text = ""
        
    }
    
    
    func shakeTextField() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0]
        answerTextField.layer.add(animation, forKey: "shake")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterButton(UIButton())
           return true
       }
    
    @IBAction func resetGame(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        }
    
}

