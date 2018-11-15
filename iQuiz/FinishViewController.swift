//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 11/5/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
  
  @IBOutlet weak var congra: UILabel!
  @IBOutlet weak var score: UILabel!
  
  var numCorrect = 0
  var numTotal = 0
  var urlString = ""
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "backToMain" {
      let mainVC = segue.destination as! ViewController
      mainVC.urlString = urlString
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    score.text = String(numCorrect) + " / " + String(numTotal)
    if numCorrect == numTotal {
      congra.text = "Perfect!"
    } else if numCorrect == 0 {
      congra.text = "Emmm"
    } else {
      congra.text = "Almost!"
    }
  }
}
