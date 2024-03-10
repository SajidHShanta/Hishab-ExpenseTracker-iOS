//
//  PasswordTF.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import UIKit

class PasswordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        
        //show/hide button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        button.tintColor = .secondaryLabel
        
        let emptyView = UILabel()
        emptyView.text = " "
        
        let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        stack.axis = .horizontal
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(emptyView)
        
        rightView = stack
        rightViewMode = .always
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
}
