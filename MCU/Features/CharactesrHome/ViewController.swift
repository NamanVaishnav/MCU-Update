//
//  ViewController.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        URLSession.shared.request(target: .characters(10, 0, ""), expecting: ModelCharacter.self) { result in
//            switch result {
//            case .success(let model):
//                print(model)
//            case .failure(let err):
//                print(err)
//            }
//        }
        
        ViewModelMCU().getCharacters { arrCharacters in
            print(arrCharacters.count)
            MCUFetchManager.shared.fetchData(fetchType: .character) { arrCharacter in
                print(arrCharacter.count)
            }
        }
        
        
//        ViewModelMCU().getComicsForCharacterId(forCharacterId: "1011334") { arrComics in
//            print(arrComics)
//        }
    }
}
