//
//  ViewController.swift
//  TestingAlamofire
//
//  Created by Ahmad Musallam on 04/03/2024.
//

import UIKit
import Alamofire


class PetsTableViewController: UITableViewController {

    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           fetchPetsData()
        
        
    }

    private func fetchPetsData() {
        NetworkManager.shared.fetchPets{ fetchedPets in
            DispatchQueue.main.async {
                self.pets = fetchedPets ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
}









