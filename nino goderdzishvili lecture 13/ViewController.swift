//
//  ViewController.swift
//  nino goderdzishvili lecture 13
//
//  Created by Nino Goderdzishvili on 11/20/22.
//

import UIKit

class Person {
    var firstName: String
    var lastName: String
    var age: UInt
    
    internal init(firstName: String, lastName: String, age: UInt) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

class ViewController: UIViewController {
    
    var persons: [Person] = []
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    
    @IBOutlet weak var lastNameTxtField: UITextField!
    
    @IBOutlet weak var ageTxtField: UITextField!
    
    @IBOutlet weak var personsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        personsTableView.delegate = self
        personsTableView.dataSource = self
    }
    
    
    @IBAction func addPerson(_ sender: Any) {
        let firstName = firstNameTxtField.text ?? ""
        let lastName = lastNameTxtField.text ?? ""
        let age = ageTxtField.text ?? ""
        
        if firstName == "" || lastName == "" || age == "" {
            showAlert(message: "გთხოვთ შეიყვანოთ ყველა მონაცემი")
        } else if (UInt(age) ?? 0 <= 0) {
            print("age: \(age)")
            showAlert(message: "ასაკი უნდა აღემატებოდეს 0-ს")
        } else {
            let ageToInt = (age as NSString).integerValue
            
            let person = Person(firstName: firstName, lastName: lastName, age: UInt(ageToInt))
            
            persons.append(person)
            
            personsTableView.reloadData()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "შეცდომა", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonsCell", for: indexPath) as?
                PersonsCell else {
            return UITableViewCell()
        }
        
        let currentPerson = persons[indexPath.row]
        cell.firstNameLabel.text = currentPerson.firstName
        cell.lastNameLabel.text = currentPerson.lastName
        cell.ageLabel.text = "\(currentPerson.age)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
