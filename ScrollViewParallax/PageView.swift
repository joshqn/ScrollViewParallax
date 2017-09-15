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
    // Basic text and view setup
    headerTextField.isUserInteractionEnabled = false
    headerTextField.textColor = .black
    headerTextField.textAlignment = .center
    headerTextField.sizeToFit()
    
    paragraphTextView.isUserInteractionEnabled = false
    paragraphTextView.textColor = .black
    paragraphTextView.textAlignment = .center
    paragraphTextView.sizeToFit()
    paragraphTextView.isScrollEnabled = false
    paragraphTextView.backgroundColor = .clear
    
    // Configuring the textfield/view for autoLayout
    headerTextField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(headerTextField)
    paragraphTextView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(paragraphTextView)
    
    // Creating and activating the constraints
    NSLayoutConstraint.activate([
      headerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      headerTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      paragraphTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      paragraphTextView.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 20),
      paragraphTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (2/3))
    ])
  }
  
}


















