//
//  ProductDetailViewController.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation
import UIKit

class ProductDetailViewController: ViewController<ProductDetailViewModel> {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var badge: UILabel!
    @IBOutlet weak var storageOptions: UIStackView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var freeShipping: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.getProductDetail()
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.configureUI()
            }
        }
    }
    
    func configureUI() {
        let urlLogo = URL(string: viewModel?.detailData?.imageUrl ?? "")
        let data2 = try? Data(contentsOf: urlLogo!)
        productImage.image = UIImage(data: data2!)
        brand.text = viewModel?.detailData?.mkName
        name.text = viewModel?.detailData?.productName
        badge.text = viewModel?.detailData?.badge
        rating.text = "\(String(describing: viewModel?.detailData?.rating ?? 0.0))"
        price.text = "\(String(describing: viewModel?.detailData?.price ?? 0.0)) TL"
        
        if viewModel?.detailData?.freeShipping == true {
            freeShipping.isHidden = false
        } else {
            freeShipping.isHidden = true
        }
        
        lastUpdate.text = "Son güncelleme: \(String(describing: viewModel?.detailData?.lastUpdate ?? ""))"
        
        storageOptions.alignment = .center
        storageOptions.distribution = .fillEqually
        storageOptions.axis = .vertical
        storageOptions.spacing = 10.0
        storageOptions.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel?.detailData?.storageOptions?.forEach({value in
            var myLabel = UILabel()
            let frameLabel = CGRect(x: 100, y: 100, width: 200, height: 30)
            myLabel = UILabel(frame: frameLabel)
            myLabel.text = value
            myLabel.textAlignment = .center
            myLabel.clipsToBounds = true
            storageOptions.addArrangedSubview(myLabel)
        })
    }
}

extension ProductDetailViewController: StoryboardInstantiable {

    public static var storyboardName: String { return "ProductDetail" }
    public static var storyboardIdentifier: String? { return "ProductDetailViewController" }
}
