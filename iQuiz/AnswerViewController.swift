//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 11/5/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

  var isCorrect = false
  var question: String = ""
  var answer: String = ""
  var questionsLeft: [Question] = []
  var numTotal = 0;
  var numCorrect = 0;
  var urlString = ""
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var correctLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    questionLabel.text = question
    answerLabel.text = answer
    if isCorrect {
      numCorrect += 1
      correctLabel.text = "Correct!"
    } else {
      correctLabel.text = "Wrong!"
    }
  }
    
  @IBAction func nextClick(_ sender: UIButton) {
    if questionsLeft.count == 0 {
      performSegue(withIdentifier: "answerToFinish", sender: self)
    } else {
      performSegue(withIdentifier: "answerToQuestion", sender: self)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "answerToQuestion" {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = questionsLeft
      questionVC.numCorrect = numCorrect
      questionVC.numTotal = numTotal
      questionVC.urlString = urlString
    } else if segue.identifier == "answerToFinish" {
      let finishVC = segue.destination as! FinishViewController
      finishVC.numCorrect = numCorrect
      finishVC.numTotal = numTotal
      finishVC.urlString = urlString
    }
  }
}
