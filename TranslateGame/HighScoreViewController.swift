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
    var highScoreArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadHighScore()
        highScoreArray.append(highScore)
        highScoreArray.sort(by: >)
        saveHighScore( )
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
     
    @IBAction func backButton(_ sender: UIButton) { self.dismiss(animated: true)
    }
    
    func saveHighScore() {
        UserDefaults.standard.set(highScoreArray, forKey: "highScoreArray")
        
    }
    
    func loadHighScore() {
        if let savedHighScoreArray = UserDefaults.standard.array(forKey: "highScoreArray") as? [Int] {
            highScoreArray = savedHighScoreArray
        }
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
