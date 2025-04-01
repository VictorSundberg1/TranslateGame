//
//  ViewController.swift
//  TranslateGame
//
//  Created by Victor Sundberg on 2025-03-24.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("Testing GitHub push - Hello World!")
    }

    @IBAction func startGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "startGame", sender: self)
    }
    
    @IBAction func showHighScoresButton(_ sender: UIButton) {
        performSegue(withIdentifier: "showHighScores", sender: self)
    }
    
}

