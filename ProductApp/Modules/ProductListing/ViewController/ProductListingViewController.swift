//
//  ProductListingViewController.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation
import UIKit

class ProductListingViewController: ViewController<ProductListingViewModel>, HorizontalProductDelegate{
  
    @IBOutlet weak var productCollectionView: UICollectionView!
    var page: Int = 0
     var isPageRefreshing:Bool = false
    
    func toDetail(code: String) {
        let vm = ProductDetailViewModel()
        let vc = ProductDetailViewController.instantiate(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
        vm.code = code
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getProducts(endpoint: "59906f35-d5d5-40f7-8d44-53fd26eb3a05")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.register(UINib(nibName: "HorizontalProductCell", bundle:nil), forCellWithReuseIdentifier: "HorizontalProductCell")
        
        productCollectionView.register(UINib(nibName: "ProductItemCell", bundle:nil), forCellWithReuseIdentifier: "ProductItemCell")
        
        navigationItem.hidesBackButton = true
        
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.isPageRefreshing = false
                self?.productCollectionView.reloadData()
            }
        }
    }
}

extension ProductListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel?.products?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            if indexPath.section == 0 {
                return CGSize(width: collectionView.frame.width , height: 400)

            }
            return CGSize(width: (collectionView.frame.width - 24) / 2, height: 200.0)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0  {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:"HorizontalProductCell",
                            for: indexPath
                        ) as! HorizontalProductCell
            cell.delegate = self
            cell.products = viewModel?.horizontalProducts
            return cell
        }
      
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"ProductItemCell",
                        for: indexPath
                    ) as! ProductItemCell
    
        let urlLogo = URL(string: viewModel?.products?[indexPath.row].imageUrl ?? "") ?? URL(fileURLWithPath: "")
        let data2 = try? Data(contentsOf: urlLogo)
        cell.productImage.image = UIImage(data: data2 ?? Data())
        cell.productName.text = viewModel?.products?[indexPath.row].name
        cell.productPrice.text = "\(String(describing: Int(viewModel?.products?[indexPath.row].price ?? 0.0))) TL"
        if viewModel?.products?[indexPath.row].countOfPrice ?? 0.0 > 0 {
            cell.countOfPrices.text = "\(String(describing: Int(viewModel?.products?[indexPath.row].countOfPrice ?? 0.0))) satıcı"
        }
        if viewModel?.products?[indexPath.row].followCount ?? 0.0 > 0 {
            cell.followCount.text = "\(String(describing: Int(viewModel?.products?[indexPath.row].followCount ?? 0.0))) takipçi"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let vm = ProductDetailViewModel()
        let vc = ProductDetailViewController.instantiate(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
        vm.code = String(describing: viewModel?.products?[indexPath.row].code)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(self.productCollectionView.contentOffset.y >= (self.productCollectionView.contentSize.height - self.productCollectionView.bounds.size.height)) {
                let url = viewModel?.nextUrl
                let urlArr = url?.components(separatedBy: "/")

                let endpoint = urlArr?.last
                
                viewModel?.getProducts(endpoint: endpoint ?? "")
            }
    } 
}

extension ProductListingViewController: StoryboardInstantiable {

    public static var storyboardName: String { return "ProductListing" }
    public static var storyboardIdentifier: String? { return "ProductListingViewController" }
}
