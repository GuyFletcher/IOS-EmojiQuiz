//
//  FinalViewController.swift
//  EmojiQuiz
//
//  Created by Hart, Fletcher on 2/15/18.
//  Copyright © 2018 Hart, Fletcher. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    var score: Int?
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var saveScore: UIButton!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(score!)
        finalScore.text = String(score!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func saveFinalScore(_ sender: UIButton) {
        struct HIGHSCORE {
            var name : String
            var score : Int
            
            init(name : String, score : Int) {
                self.name = name
                self.score = score
            }
            
            init?(dictionary : [String:Any]) {
                guard let name = dictionary["name"],
                    let score = dictionary["score"] else { return nil }
                self.init(name: name as! String, score: score as! Int)
            }
            
            var propertyListRepresentation : [String:String] {
                return ["name" : name, "score" : String(score) ]
            }

        }
        var highScores = [HIGHSCORE]()
        
        
        
        if let scores = UserDefaults.standard.object(forKey: "highscores") as? [[String:String]] {
            highScores = scores.flatMap{ HIGHSCORE(dictionary: $0) }
        }
        
        
        
        let newscores = highScores.map{ $0.propertyListRepresentation }
        UserDefaults.standard.set(newscores, forKey: "songs")
        
        
        print(newscores)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
