//
//  ViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 10/29/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

struct Question {
  var q : String
  var a : Int
  var ans : [String]
}

struct Subject {
  var title : String
  var desc : String
  var image : String
}

class SubjectTableViewCell : UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var img: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let subjects = [
    Subject(title: "Math", desc: "Everything about numbers", image: "one"),
    Subject(title: "Music", desc: "Some music balabala", image: "two"),
    Subject(title: "Game", desc: "How do u know about games", image: "three")
  ]
  
  let mathQuestions = [
    Question(q: "1+1=?", a: 1, ans: ["1", "2", "3", "4"]),
    Question(q: "Which one is NOT a prime number", a: 0, ans: ["87", "13", "67", "23"])
  ]
  
  let musicQuestion = [
    Question(q: "Which is a string instrument", a: 2, ans: ["Drum",  "Saxophone", "Balalaika", "Flute"]),
    Question(q: "Guitar was invented in", a: 0, ans: ["Spain", "America", "India", "Korea"])
  ]
  
  let gameQuestion = [
    Question(q: "What is the most sold game \n on Steam in 2018", a: 1, ans: ["GTA", "PUBG", "Assasin's Creed: Odyssey", "CS: GO"]),
    Question(q: "Which team got League of Legend \n 2018 Word Championship", a: 3, ans: ["RNG", "KT", "Fnatic", "IG"])
  ]
  
  var currentQuestion: [Question] = []
  
  var category: Int = 0
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func settingsClick(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: nil, message: "Check back for settings", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return subjects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
    let subject = subjects[indexPath.row]
    cell.title?.text = subject.title
    cell.desc?.text = subject.desc
    cell.img?.image = UIImage(named: subject.image)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      currentQuestion = mathQuestions
    case 1:
      currentQuestion = musicQuestion
    default:
      currentQuestion = gameQuestion
    }
    performSegue(withIdentifier: "categoryToQuestion", sender: self)
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "categoryToQuestion" {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = currentQuestion
      questionVC.numTotal = currentQuestion.count
    }
  }

}

