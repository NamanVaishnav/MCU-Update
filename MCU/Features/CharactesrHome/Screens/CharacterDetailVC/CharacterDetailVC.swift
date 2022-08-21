//
//  CharacterDetailVC.swift
//  MCU
//
//  Created by Naman Vaishnav on 21/08/22.
//

import UIKit

class CharacterDetailVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var character: CharacterResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupView()
    }
    
    private func setupView() {
        // character image
        if let path = character?.thumbnail?.path, let ext = character?.thumbnail?.thumbnailExtension {
            let imgURL = path + "." + ext
            imgView.sd_setImage(with: URL(string: imgURL))
        }
        
        // character name
        if let name = character?.name, name.count > 0 {
            self.lblTitle.text = name
        } else {
            self.lblTitle.isHidden = true
        }
        
        // character description
        if let description = character?.description, description.count > 0 {
            self.lblDescription.text = description
        } else {
            self.lblDescription.isHidden = true
        }
        
        // character comics
        if let comicsCount = character?.comics?.count, comicsCount > 0 {
            self.collectionView.collectionViewLayout = createLayout()
            self.collectionView.reloadData()
        } else {
            viewCollection.isHidden = true
        }
    }
    
    /// register cell in collectionView
    private func registerCell(){
        // Register cell classes
        self.collectionView.register(UINib.init(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
    }
    
    /// create layout for collectionview cell
    /// - Returns: compositionalLayout which later been assign to collectionView to render UI as per the given sected cell
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        // Item
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 6)
        // Group
        let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.4), height: .fractionalHeight(1), item: item, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        // Configuration
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        // return
        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    }
}

extension CharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character?.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aCell: CharacterCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {return UICollectionViewCell()}
        if let obj = character?.comics?[indexPath.row] {
            if let path = obj.thumbnail?.path, let ext = obj.thumbnail?.thumbnailExtension {
                let imgURL = path + "." + ext
                aCell.imgView.sd_setImage(with: URL(string: imgURL))
            }
            if let name = obj.title {
                aCell.btnName.isHidden = false
                aCell.btnName.setTitle(name, for: .normal)
            } else {
                aCell.btnName.isHidden = true
            }
            return aCell
        } else {
            return UICollectionViewCell()
        }
    }
}
