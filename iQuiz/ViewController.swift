//
//  ViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 10/29/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

struct Question {
  var answer : String
  var answers : [String]
  var text : String
  
  init(json: [String: Any]) {
    text = json["text"] as! String
    answer = json["answer"] as! String
    answers = json["answers"] as! [String]
    
  }
}

struct Course {
  var title : String
  var desc : String
  var questions : [Question]
  
  init(json : [String : Any]) {
    title = json["title"] as! String
    desc = json["desc"] as! String
    questions = []
    let questionArray = json["questions"] as! [Any]
    for question in questionArray {
      questions.append(Question(json: question as! [String : Any]))
    }
  }
}

class SubjectTableViewCell : UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var img: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var courses : [Course] = []
  let file = "data.txt"
  var urlString = "http://tednewardsandbox.site44.com/questions.json"
  var currentQuestion: [Question] = []
  var timer = Timer()
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func settingsClick(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Load from url", message: "enter a JSON url to start", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: {[weak alert] (_) in
      self.urlString = alert!.textFields![0].text!
      self.loadUrl()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
    let course = courses[indexPath.row]
    cell.title?.text = course.title
    cell.desc?.text = course.desc
    cell.img?.image = UIImage(named: "course")
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    currentQuestion = courses[indexPath.row].questions
    performSegue(withIdentifier: "categoryToQuestion", sender: self)
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add pull to refresh
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
    self.tableView.refreshControl = refreshControl
    loadUrl()
  }
  
  @objc func refreshPage(refreshControl: UIRefreshControl) {
    loadUrl()
  }
  
  func loadUrl() {
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if err != nil {
        self.loadLocalData()
      }
      guard let data = data else { return }
      do {
        let stringData = String(data: data, encoding: .utf8)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
          let fileURL = dir.appendingPathComponent(self.file)
          do {
            try stringData!.write(to: fileURL, atomically: false, encoding: .utf8)
          } catch {
            print("Error writing local data!")
          }
        }
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        self.loadJson(json)
      } catch let jsonErr { // when error loading json from the url, use local data stored last time.
        self.loadLocalData()
        print("Error serialize json: ", jsonErr)
      }
    }.resume()
  }
  
  func loadJson(_ json : Any) {
    self.courses = []
    if let courseArray = json as? [Any] {
      for course in courseArray {
        self.courses.append(Course(json: course as! [String : Any]))
      }
      DispatchQueue.main.async {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
      }
    }
  }
  
  func loadLocalData() {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let fileURL = dir.appendingPathComponent(self.file)
      do {
        let localData = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8)
        let json = try JSONSerialization.jsonObject(with: localData!, options: .mutableContainers)
        self.loadJson(json)
        print("Local data loaded")
      } catch {
        print("Error loading local data!")
      }
    }
    
    // refresh data every 30s
    self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(ViewController.timeRefresh), userInfo: nil, repeats: true)
  }
  
  @objc func timeRefresh() {
    loadUrl()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "categoryToQuestion" {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = currentQuestion
      questionVC.numTotal = currentQuestion.count
      questionVC.urlString = urlString
    }
  }

}

