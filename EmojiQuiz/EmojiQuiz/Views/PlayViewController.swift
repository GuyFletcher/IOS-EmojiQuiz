//
//  PlayViewController.swift
//  EmojiQuiz
//
//  Created by Hart, Fletcher on 1/30/18.
//  Copyright © 2018 Hart, Fletcher. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        if let path = Bundle.main.url(forResource: "q&a", withExtension: "plist"), let dict = NSDictionary(contentsOf: path) as? [String : String]
        {
            var keys = Array(dict.keys)
            keys = keys.shuffled()
            emoji.text = keys[0]
        }
        
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
        
        var change = answerLabel.text!
        let buttonText: String = sender.titleLabel!.text!
        let start = change.index(change.startIndex, offsetBy: 0)
        let end = change.index(change.startIndex, offsetBy: 0 + 1)
        change.replaceSubrange(start..<end, with: buttonText)
        
        answerLabel.text = change
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
