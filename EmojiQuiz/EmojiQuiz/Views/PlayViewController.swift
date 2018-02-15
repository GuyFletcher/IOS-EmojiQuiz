//
//  PlayViewController.swift
//  EmojiQuiz
//
//  Created by Hart, Fletcher on 1/30/18.
//  Copyright © 2018 Hart, Fletcher. All rights reserved.
//

import UIKit

import AVFoundation

var player: AVAudioPlayer?

//Function below taken from https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
func playSound(soundName: String) {
    guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else { return }
        
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

class PlayViewController: UIViewController {
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var numQuestions: Int = 0
    var questionType: Bool = false
    var keys = [String]()
    var newDict: [String : String] = [:]
    var currentKey = 0
    var change = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if questionType == false {
            if let path = Bundle.main.url(forResource: "q&a", withExtension: "plist"), let dict = NSDictionary(contentsOf: path) as? [String : String]
            {
                newDict = dict
                keys = Array(dict.keys)
                keys = keys.shuffled()
                emoji.text = keys[0]
            }
        }
        else {
            if let path = Bundle.main.url(forResource: "bad", withExtension: "plist"), let dict = NSDictionary(contentsOf: path) as? [String : String]
            {
                newDict = dict
                keys = Array(dict.keys)
                keys = keys.shuffled()
                emoji.text = keys[0]
            }
        }
        
        
        print(newDict[keys[0]])
        
        for _ in 1...newDict[keys[0]]!.count
        {
            change = "\(change)\("-")"
        }
        print(change)
        answerLabel.text = change
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //????https://stackoverflow.com/questions/24789515/how-to-replace-nth-character-of-a-string-with-another
    @IBAction func changeLetter(_ sender: UIButton) {
        
        var toChange = Array(answerLabel.text!)
        let soundMaybe = toChange
        var buttonText = Array(sender.titleLabel!.text!)
        
        
        var characters = Array(newDict[keys[currentKey]]!)
        print(buttonText)
        
        for i in 0...(characters.count-1) {
            if characters[i] == buttonText[0] {
                toChange[i] = buttonText[0]
                print(toChange)
            }
        }
        
        if toChange == soundMaybe {
            playSound(soundName: "buzz")
            print("Sound")
        }
        else
        {
            answerLabel.text = String(toChange)
            //don't want to renable it so commented out for now
            //sender.isEnabled = false
            
            if answerLabel.text == newDict[keys[currentKey]]
            {
                print("You got it!")
                playSound(soundName: "win")
                currentKey += 1
                if currentKey < numQuestions {
                    //changes question, add animation here
                    print("Plus one")
                    emoji.text = keys[currentKey]
                    change = ""
                    
                    for _ in 1...newDict[keys[0]]!.count
                    {
                        change = "\(change)\("-")"
                    }
                    answerLabel.text = change
                }
                else {
                    print("Game Over!")
                    //Add segue to final view controller
                }
                
            }
        }

        sender.isEnabled = false
    }

}

extension Array {
    public func shuffled() -> Array<Element> {
        var shuffledArray = self // value semantics (Array is Struct) makes this a copy
        if count < 2 { return shuffledArray } // already shuffled
        for i in (1..<count).reversed() { // count backwards
            let position = Int(arc4random_uniform(UInt32(i + 1))) // random to swap
            if i != position { // swap with the end, don't bother with self swaps
                shuffledArray.swapAt(i, position)
            }
        }
        return shuffledArray
    }
}
