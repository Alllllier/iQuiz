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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    score.text = String(numCorrect) + " / " + String(numTotal)
    switch numCorrect {
    case 2:
      congra.text = "Perfect!"
    case 1:
      congra.text = "Almost!"
    default:
      congra.text = "Emmm"
    }
  }
}
