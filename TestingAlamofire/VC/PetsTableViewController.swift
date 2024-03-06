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
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(navButtonPress))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(reloadButtonPress))
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
        cell.imageView?.image=UIImage(named: pet.image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PetDetailsViewController()
        let pet = pets[indexPath.row]
        detailVC.pets = pet
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]
            NetworkManager.shared.deletePet(petID: petToDelete.id!) { success in
                DispatchQueue.main.async {
                    if success {
                        self.pets.remove(at: indexPath.row)

                        tableView.deleteRows(at: [indexPath], with: .middle)
                    } else {
                    }
                }
            }
        }
    }
    
    private func setupNavigationBar() {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetButton))
            }
    
    @objc private func addPetButton() {
        
                let navigationController = UINavigationController(rootViewController: PetFormViewController())
                present(navigationController, animated: true, completion: nil)
            }
    @objc func navButtonPress(){
        
        let popover = PetFormViewController()
        present(popover, animated: true)
    }
    @objc func reloadButtonPress(){
            fetchPetsData()
            tableView.reloadData()
            print("Refreshed")
        }
}


extension PetsTableViewController{
    func fetchPets(){
        NetworkManager.shared.fetchPets { pets in
            DispatchQueue.main.async {
                self.pets = pets ?? []
                self.tableView.reloadData()
            }
        }
    }

}

