//
//  ViewControllerExtension.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 02.05.2023.
//

import Foundation
import UIKit
import Swinject


extension UIViewController {
    
    var container: Container {
        ContainerDI.container
    }
    
}
