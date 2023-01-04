//
//  ViewController.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    associatedtype T
    init(viewModel: T)
}

public class ViewController<U>: UIViewController, UIGestureRecognizerDelegate {
    typealias T = U
    var viewModel: T?
    var spinner = UIActivityIndicatorView(style: .large)
    var loadingView = UIView()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.backgroundColor = .green
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isUserInteractionEnabled = true
        
        view.addSubview(loadingView)
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        loadingView.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        
        loadingView.isHidden = true
    }
    
    func startLoading(){
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }
    
    func popScreen(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func alert(message:String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Uyarı!", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
