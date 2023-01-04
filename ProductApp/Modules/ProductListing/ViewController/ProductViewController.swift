//
//  ProductViewController.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vm = ProductListingViewModel()
            let vc = ProductListingViewController.instantiate(viewModel: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
