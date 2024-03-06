//
//  PetFormViewController.swift
//  TestingAlamofire
//
//  Created by Ahmad Musallam on 05/03/2024.
//
import Eureka
import UIKit

class PetFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Personal Information")
        
        <<< TextRow() { row in
            row.title = "Name"
            row.placeholder = "Enter pet name"
            row.tag = "\(tagpets.name)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }
            
        }
        <<< SwitchRow("isAdopted") {
            $0.title = "Adopted?"
            $0.value = true
            
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
        }

        <<< TextRow() { row in
            row.title = "Image"
            row.placeholder = "Enter pet image"
            row.tag = "\(tagpets.image)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }
        }
       
        <<< IntRow("petAge") { row in
            row.title = "Age"
            row.placeholder = "Enter pet age"
            row.tag = "\(tagpets.age)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }
        }
        <<< TextRow() { row in
            row.title = "Gender"
            row.placeholder = "Enter pet gender"
            row.tag = "\(tagpets.gender)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                  if !row.isValid {
                      cell.titleLabel?.textColor = .red
                  }
              }
        }
        <<< ButtonRow() { row in
            row.title = "Submit"
            row.onCellSelection({ cell, row in
                print("button tapped")
                self.submitTapped()
            })
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitTapped))
        
        
    }
    @objc func submitTapped() {
      
        let errors = form.validate()
        guard errors.isEmpty else{
            print("Error, something is missing! 😡")
            
            presentAlertWithTitle(title: "Error", message: "Error, something is missing! 😡")
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: "\(tagpets.name)")
        let isAdoptedRow: SwitchRow? = form.rowBy(tag: "isAdopted")
        let imageRow: TextRow? = form.rowBy(tag: "\(tagpets.image)")
        let ageRow: IntRow? = form.rowBy(tag: "\(tagpets.age)")
        let genderRow: TextRow? = form.rowBy(tag: "\(tagpets.gender)")
        

        let name = nameRow?.value ?? ""
        let isAdopted = isAdoptedRow?.value ?? false
        let image = imageRow?.value ?? ""
        let age = ageRow?.value ?? 0
        let gender = genderRow?.value ?? ""
        
       
        let pet = Pet(id: nil, name: name, adopted: isAdopted, image: image, age: age, gender: gender)
        
     
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("Pet added successfully")
                  
                } else {
                  
                    print("Failed to add pet.")
                }
            }
        }
        
        //navigate to the details
    }
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    enum tagpets{
        case name
        case image
        case age
        case gender
        
        
    }
}
