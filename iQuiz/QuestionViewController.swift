//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 11/5/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
  var questions: [Question] = []
  var currentQuestion : Question?
  var currentAnswer: Int = 0
  var numCorrect = 0;
  var numTotal = 0;
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var bt1: UIButton!
  @IBOutlet weak var bt2: UIButton!
  @IBOutlet weak var bt3: UIButton!
  @IBOutlet weak var bt4: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    currentQuestion = questions.removeLast();
    questionLabel.text = currentQuestion?.q
    bt1.setTitle(currentQuestion?.ans[0], for: .normal)
    bt2.setTitle(currentQuestion?.ans[1], for: .normal)
    bt3.setTitle(currentQuestion?.ans[2], for: .normal)
    bt4.setTitle(currentQuestion?.ans[3], for: .normal)
  }
  
  @IBAction func answerClicked(_ sender: UIButton) {
    currentAnswer = sender.tag
    
    bt1.setTitleColor(UIColor.blue, for: .normal)
    bt2.setTitleColor(UIColor.blue, for: .normal)
    bt3.setTitleColor(UIColor.blue, for: .normal)
    bt4.setTitleColor(UIColor.blue, for: .normal)

    sender.setTitleColor(UIColor.red, for: .normal)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "questionToAnswer" {
      let answerVC = segue.destination as! AnswerViewController
      answerVC.question = (currentQuestion?.q)!
      answerVC.answer = (currentQuestion?.ans[(currentQuestion?.a)!])!
      answerVC.isCorrect = currentAnswer == currentQuestion?.a
      answerVC.questionsLeft = questions
      answerVC.numCorrect = numCorrect
      answerVC.numTotal = numTotal
    }
  }
}
