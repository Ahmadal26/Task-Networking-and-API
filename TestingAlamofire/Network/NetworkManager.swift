//
//  NetworkManager.swift
//  TestingAlamofire
//
//  Created by Ahmad Musallam on 04/03/2024.
//

import Foundation
import Alamofire
class NetworkManager {
    
    private let baseURL = "https://coded-pets-api-crud.eapi.joincoded.com/pets"
    static let shared = NetworkManager()
    
    
    
    func fetchPets(completion: @escaping ([Pet]?) -> Void) {
        AF.request(baseURL).responseDecodable(of: [Pet].self) { response in
            switch response.result {
            case .success(let pets):
                completion(pets)
            case .failure(let error):
                print(error)
                completion(nil)
            }
            
            
        }
    }

    
    func addPet(pet: Pet, completion: @escaping (Bool) -> Void) {
        AF.request(baseURL, method: .post, parameters: pet, encoder: JSONParameterEncoder.default).response { response in
            switch response.result {
            case .success(_):
                print(true)
                completion(true)
            case .failure(_):
                print(false)
                completion(false)
            }
        }
    }

    
    func deletePet(petID: Int, completion: @escaping (Bool) -> Void) {
        AF.request("\(baseURL)/\(petID)", method: .delete).response { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print("Error occurred while deleting the pet: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    
}
