//
//  PageView.swift
//  PagingScrollView
//

import Foundation
import UIKit

class PageView: UIView {
  
  // Private so that it can only be modified from within the class
  private var headerTextField = UITextField()
  // When this property is set it will update the headerTextField text
  var headerText: String = "" {
    didSet {
      headerTextField.text = headerText
    }
  }
  
  // Private so that you can only change from within the class
  private var paragraphTextView = UITextView()
  // When this property is set it will update the paragraphTextView text
  var paragraphText: String = "" {
    didSet {
      paragraphTextView.text = paragraphText
    }
  }
  
  private var headerCenterXAnchor = NSLayoutConstraint() {
    willSet {
      headerCenterXAnchor.isActive = false
    }
    didSet {
      headerCenterXAnchor.isActive = true
    }
  }
  private var paragraphCenterXAnchor = NSLayoutConstraint() {
    willSet {
      paragraphCenterXAnchor.isActive = false
    }
    didSet {
      paragraphCenterXAnchor.isActive = true
    }
  }
  
  // Designated Init method
  init(headerText: String, paragraphText: String, backgroundColor: UIColor) {
    super.init(frame: .zero)
    setup()
    self.headerTextField.text = headerText
    self.paragraphTextView.text = paragraphText
    self.backgroundColor = backgroundColor
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    headerTextField.isUserInteractionEnabled = false
    headerTextField.textColor = .black
    headerTextField.textAlignment = .center
    
    paragraphTextView.isUserInteractionEnabled = false
    paragraphTextView.textColor = .black
    paragraphTextView.textAlignment = .center
    paragraphTextView.sizeToFit()
    paragraphTextView.isScrollEnabled = false
    paragraphTextView.backgroundColor = .clear
    
    headerTextField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(headerTextField)
    paragraphTextView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(paragraphTextView)
    
    // Added these two lines to get a reference to the UI items centerXAnchor constraints
    headerCenterXAnchor = headerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    paragraphCenterXAnchor = paragraphTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    
    // Replaced the old constraints with the variable names here to be activated when setup is called
    NSLayoutConstraint.activate([
      headerCenterXAnchor,
      headerTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      paragraphCenterXAnchor,
      paragraphTextView.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 20),
      paragraphTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (2/3))
    ])
  }
  
  func updateViewCenterXAnchor(with constant: CGFloat) {
    headerCenterXAnchor = self.headerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
    paragraphCenterXAnchor = self.paragraphTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
  }
  
}


















