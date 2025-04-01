//
//  HighScoreViewController.swift
//  TranslateGame
//
//  Created by Victor Sundberg on 2025-03-25.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var highScore = 0
    var highScoreArray: [String] = []
    var playerName = ""
    var isNewHighScore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let playerString = "\(highScore)p - \(playerName)"
        
        loadHighScore()
        isNewHighScore = checkForNewHighScore()
        
        if playerName.isEmpty && highScore == 0{
            return
        } else {
            highScoreArray.append(playerString)
            highScoreArray.sort(by: >)
            saveHighScore()
            
            if isNewHighScore {
               showCelebrationAnimation()
            }
        }
        
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        cell.textLabel?.text = String(highScoreArray[indexPath.row])
        return cell
    }
    
    func checkForNewHighScore() -> Bool {
            
            if highScoreArray.isEmpty && highScore > 0 {
                return true
            }
            
      
        if let topScoreEntry = highScoreArray.first {
        
            if let scoreEndPosition = topScoreEntry.firstIndex(of: "p") {
                let scoreText = topScoreEntry[..<scoreEndPosition]
                        
                if let existingTopScore = Int(scoreText) {

                    return highScore > existingTopScore
                }
            }
        }
            
            return false
        }
        
    func showCelebrationAnimation() {
        // Create a label for the celebration message
        let celebrationLabel = UILabel()
        celebrationLabel.text = "CONGRATS NEW RECORD! 🎉"
        celebrationLabel.textAlignment = .center
        celebrationLabel.font = UIFont.boldSystemFont(ofSize: 24)
        celebrationLabel.textColor = .white
        celebrationLabel.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 0.8)
        celebrationLabel.layer.cornerRadius = 10
        celebrationLabel.clipsToBounds = true
        
        // Increase the width from 250 to 350 and height from 50 to 60
        celebrationLabel.frame = CGRect(x: 0, y: 0, width: 350, height: 60)
        celebrationLabel.center = CGPoint(x: view.center.x, y: -50) // Start above the screen
        view.addSubview(celebrationLabel)
        
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            celebrationLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        }, completion: { _ in
            // After a delay, animate it back up
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                celebrationLabel.center = CGPoint(x: self.view.center.x, y: -50)
            }, completion: { _ in
                celebrationLabel.removeFromSuperview()
            })
        })
    }
     
    @IBAction func backButton(_ sender: UIButton) { self.dismiss(animated: true)
    }
    
    func saveHighScore() {
        UserDefaults.standard.set(highScoreArray, forKey: "highScoreArray")
    }
    
    func loadHighScore() {
        if let savedHighScoreArray = UserDefaults.standard.array(forKey: "highScoreArray") as? [String] {
            highScoreArray = savedHighScoreArray
        }
    }
    
    @IBAction func clearDataButton(_ sender: UIButton) {
        clearData()
    }
    
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: "highScoreArray")
        highScoreArray.removeAll()
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
