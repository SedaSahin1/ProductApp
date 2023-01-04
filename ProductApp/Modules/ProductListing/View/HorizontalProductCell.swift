//
//  HorizontalProductCell.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation
import UIKit

protocol HorizontalProductDelegate {
    func toDetail(code: String)
}

final class HorizontalProductCell: UICollectionViewCell {
    
    var delegate: HorizontalProductDelegate?

    var products: [HorizontalProductModel]?{
        didSet {
            horizontalProductCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var horizontalProductCollectionView: UICollectionView!{
        didSet{
         //   horizontalProductCollectionView.decelerationRate = .fast
            horizontalProductCollectionView.isPagingEnabled = true
            horizontalProductCollectionView.dataSource = self
            horizontalProductCollectionView.delegate = self
            horizontalProductCollectionView.register(UINib(nibName: "HorizontalProductItemCell", bundle:nil), forCellWithReuseIdentifier: "HorizontalProductItemCell")
            horizontalProductCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet{
       //     pageControl.numberOfPages = products?.count ?? 0
        }
    }
}

extension HorizontalProductCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return products?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
            
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:"HorizontalProductItemCell",
                            for: indexPath
                        ) as! HorizontalProductItemCell
        let urlLogo = URL(string:products?[indexPath.row].imageUrl ?? "")
        let data2 = try? Data(contentsOf: urlLogo!)
        cell.productImage.image = UIImage(data: data2!)
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.toDetail(code: String(describing:products?[indexPath.row].code ?? 0.0))
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
    
    
}

