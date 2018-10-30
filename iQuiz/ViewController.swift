//
//  ViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 10/29/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

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
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
  }

}

