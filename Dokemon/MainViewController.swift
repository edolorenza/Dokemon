//
//  ViewController.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: -Properties
    

    //MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Dokemon"
        view.backgroundColor = .systemBackground
        
        fetchData()
    
    }

    
    private func fetchData(){
        APICaller.shared.getPokemonList { result in
            switch result {
            case .success(let dokemon):
                print(dokemon.flatMap({ $0?.attack
                }))
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}

