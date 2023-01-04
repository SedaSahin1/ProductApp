//
//  StoryboardInstantiable.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation
import UIKit

public protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String? { get }
}

extension StoryboardInstantiable {
    public static var storyboardIdentifier: String? { return nil }
    public static var storyboardBundle: Bundle? { return nil }

    public static func instantiate<T: ViewModel>(viewModel: T) -> ViewController<T> {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: ViewController<T>.self))

        if let storyboardIdentifier = storyboardIdentifier {
            let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! ViewController<T>
            vc.viewModel = viewModel
            return vc
        } else {
            let vc = storyboard.instantiateInitialViewController() as! ViewController<T>
            vc.viewModel = viewModel
            return vc
        }
    }
}
