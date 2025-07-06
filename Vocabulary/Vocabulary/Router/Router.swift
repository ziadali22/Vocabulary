//
//  Router.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import Foundation
import SwiftUI
import Observation

@Observable
class Router {
    var path = NavigationPath()
    
    func navigateToageAskingView() {
        path.append(Route.ageAskingView)
    }
    
//    func navigateToGenderView() {
//        path.append(Route.genderView)
//    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Route: Hashable {
    case ageAskingView
//    case genderView
}
