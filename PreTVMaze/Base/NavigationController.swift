//
//  NavigationViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import UIKit

enum NavigationControllerStyle {
    case none, back, search
    
    func getImage() -> UIImage? {
        switch self {
        case .back:
            UIImage(systemName: "chevron.left")
        case .search:
            UIImage(systemName: "search")
        default:
            nil
        }
    }
}

class NavigationController: UINavigationController {
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?

    func setUpLeftButton(style: NavigationControllerStyle, action: (() -> ())? = nil) {
        if style == .none {
            navigationItem.setLeftBarButton(nil, animated: true)
        } else {
            self.leftButtonAction = action
            let button = UIBarButtonItem(image: style.getImage(), style: .plain, target: self, action: #selector(performLeftButtonAction))
            navigationItem.setLeftBarButton(button, animated: true)
        }
    }

    func setUpRightButton(style: NavigationControllerStyle, action: (() -> ())? = nil) {
        if style == .none {
            navigationItem.setRightBarButton(nil, animated: true)
        } else {
            self.rightButtonAction = action
            let button = UIBarButtonItem(image: style.getImage(), style: .plain, target: self, action: #selector(performRightButtonAction))
            navigationItem.setRightBarButton(button, animated: true)
        }
    }

    @objc
    func performLeftButtonAction() {
        self.leftButtonAction?()
    }

    @objc
    func performRightButtonAction() {
        self.rightButtonAction?()
    }
}
