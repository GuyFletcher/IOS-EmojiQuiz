//
//  FirstViewController.swift
//  EmojiQuiz
//
//  Created by Hart, Fletcher on 1/30/18.
//  Copyright © 2018 Hart, Fletcher. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var numQuestions: UILabel!
    @IBOutlet weak var numStep: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numStep.maximumValue = 5
        numStep.minimumValue = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numStepper(_ sender: Any) {
        numQuestions.text = Int(numStep.value).description
    }
    
    
}

