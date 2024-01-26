//
//  EasyInsuranceTVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//
import UIKit
import Foundation
import SmilesUtilities
import SmilesSharedServices


class EasyInsuranceTVC: UITableViewCell {
    
    //MARK: -  Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: -  Properties
    var callBack: ((EasyInsuranceResponseModel) -> ())?
    var updateCellData: [EasyInsuranceResponseModel]?{
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: -  Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateCellData = [EasyInsuranceResponseModel(title: "Habib"),EasyInsuranceResponseModel(title: "Habib")]
        collectionView.register(UINib(nibName: String(describing: InsuranceTypeCVC.self), bundle: .module), forCellWithReuseIdentifier: String(describing: InsuranceTypeCVC.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: -  Compositional Layout
    func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute((self.collectionView.frame.width-16)/2), heightDimension: .fractionalHeight(0.5))
            var smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            if let insuranceData = self.updateCellData, insuranceData.count <= 2 {
                smallItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute((self.collectionView.frame.width-16)/2), heightDimension: .fractionalHeight(1)))
            }
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
            
            let outerGroupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.collectionView.frame.width-16)/2), heightDimension: .fractionalHeight(1))
            let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [nestedGroup])
            
            let section = NSCollectionLayoutSection(group: outerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            section.orthogonalScrollingBehavior = .continuous
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .vertical
            
            return section
        }
    }
    
}

extension EasyInsuranceTVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return updateCellData?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let data = updateCellData?[safe: indexPath.row] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsuranceTypeCVC", for: indexPath) as? InsuranceTypeCVC else {return UICollectionViewCell()}
            
//            cell.model = data
            return cell
//        }
//        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = updateCellData?[indexPath.row] {
            callBack?(data)
        }
    }
}
