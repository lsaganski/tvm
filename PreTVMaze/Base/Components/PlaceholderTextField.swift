//
//  PlaceholderTextField.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import UIKit

class PlaceholderTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
