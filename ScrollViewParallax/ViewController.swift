//
//  ViewController.swift
//  PagingScrollView
//

import UIKit

class ViewController: UIViewController {
  
  let placeHolderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
  
  // Set the frames to zero because we'll be using AutoLayout to size them
  private var scrollView = UIScrollView(frame: .zero)
  private var stackView = UIStackView(frame: .zero)
  var views:[UIView] = []
  var pageControl = UIPageControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupScrollView()
    setupStackView(scrollView: scrollView)
    views = createAndAddViews(to: stackView)
    createAndAddPageControl()
  }
  
  func pageControlTapped(sender: UIPageControl) {
    let pageWidth = scrollView.bounds.width
    let offset = sender.currentPage * Int(pageWidth)
    UIView.animate(withDuration: 0.33, animations: { [weak self] in
      self?.scrollView.contentOffset.x = CGFloat(offset)
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.backgroundColor = .black
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    
    self.view.addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -10),
      scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
      scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
      ])
  }
  
  func setupStackView(scrollView: UIScrollView) {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    stackView.spacing = 20

    scrollView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
      ])
  }
  
  func createAndAddViews(to stackView: UIStackView) -> [UIView] {
    var views:[UIView] = []
    
    let pageView1 = PageView(headerText: "Header 1", paragraphText: placeHolderText, backgroundColor: .red)
    views.append(pageView1)
    let pageView2 = PageView(headerText: "Header 2", paragraphText: placeHolderText, backgroundColor: .orange)
    views.append(pageView2)
    let pageView3 = PageView(headerText: "Header 3", paragraphText: placeHolderText, backgroundColor: .blue)
    views.append(pageView3)
    let pageView4 = PageView(headerText: "Header 4", paragraphText: placeHolderText, backgroundColor: .green)
    views.append(pageView4)
    
    views.forEach { (view) in
      view.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(view)
      view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
      view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    return views
  }
  
  func createAndAddPageControl() {
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(pageControl)
    pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    pageControl.numberOfPages = views.count
    pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
  }


}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.bounds.width
    let pageFraction = scrollView.contentOffset.x/pageWidth
    let headerConstantFraction = pageFraction * 2
    let paragraphConstantFraction = pageFraction
    
    pageControl.currentPage = Int((round(pageFraction)))
    
    for (index, view) in views.enumerated() {
      guard let view = view as? PageView else { return }
      let headerConstant = pageWidth * (CGFloat(index * 2) - headerConstantFraction)
      let paragraphconstant = pageWidth * (CGFloat(index) - paragraphConstantFraction)
      view.updateViewCenterXAnchor(headerConstant: headerConstant, paragraphConstant: paragraphconstant)
    }
  }
}

































