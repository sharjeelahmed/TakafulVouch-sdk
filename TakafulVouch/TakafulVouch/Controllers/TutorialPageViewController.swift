//
//  TutorialPageViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 26/04/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
  weak var tutorialDelegate: TutorialViewController?
  
  private(set) lazy var orderedViewControllers: [UIViewController] = {
    // The view controllers will be shown in this order
    return [self.newColoredViewController(color: "Red"),
            self.newColoredViewController(color: "Green"),
            self.newColoredViewController(color: "Blue"),
   // self.newColoredViewController(color: "Yellow"),
    self.newColoredViewController(color: "Orange")]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    
    UINavigationBar.appearance().barTintColor = UIColor.white
    UINavigationBar.appearance().tintColor = UIColor.black
	UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    
    if let initialViewController = orderedViewControllers.first {
      scrollToViewController(viewController: initialViewController)
    }
    
    tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
  }
  
  
  /**
   Scrolls to the next view controller.
   */
  func scrollToNextViewController() {
    if let visibleViewController = viewControllers?.first {
      DispatchQueue.main.async {
        
        
        let nextViewController = self.pageViewController(self, viewControllerAfter: visibleViewController)
        if nextViewController != nil {
          self.scrollToViewController(viewController: nextViewController!)
        }else {
          
         
        }
      }
    }
  }
  /**
   Scrolls to the view controller at the given index. Automatically calculates
   the direction.
   
   - parameter newIndex: the new index to scroll to
   */
  func scrollToViewController(index newIndex: Int) {
    if let firstViewController = viewControllers?.first,
      let currentIndex = orderedViewControllers.index(of: firstViewController) {
		let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
      let nextViewController = orderedViewControllers[newIndex]
      scrollToViewController(viewController: nextViewController, direction: direction)
    }
  }
  
  private func newColoredViewController(color: String) -> UIViewController {
    return UIStoryboard(name: "Login-Pso", bundle: nil) .
      instantiateViewController(withIdentifier: "\(color)ViewController")
  }
  
  /**
   Scrolls to the given 'viewController' page.
   
   - parameter viewController: the view controller to show.
   */
  private func scrollToViewController(viewController: UIViewController,
									  direction: UIPageViewController.NavigationDirection = .forward) {
    setViewControllers([viewController],
                       direction: direction,
                       animated: true,
                       completion: { (finished) -> Void in
                        // Setting the view controller programmatically does not fire
                        // any delegate methods, so we have to manually notify the
                        // 'tutorialDelegate' of the new index.
                        self.notifyTutorialDelegateOfNewIndex()
    })
  }
  
  
  func notifyTutorialDelegateOfNewIndex() {
    if let firstViewController = viewControllers?.first,
      let index = orderedViewControllers.index(of: firstViewController) {
      
      if index == 4 {
        tutorialDelegate?.button_next.setTitle("FINISH", for: .normal)
      }else {
        tutorialDelegate?.button_next.setTitle("NEXT", for: .normal)
      }
      tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
    }
  }
  
}

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    // User is on the first view controller and swiped left to loop to
    // the last view controller.
    guard previousIndex >= 0 else {
      return nil//orderedViewControllers.last
    }
    
    guard orderedViewControllers.count > previousIndex else {
      return nil
    }
    
    return orderedViewControllers[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    // User is on the last view controller and swiped right to loop to
    // the first view controller.
    guard orderedViewControllersCount != nextIndex else {
      return nil//orderedViewControllers.first
    }
    
    guard orderedViewControllersCount > nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
  
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    
    
    
    
    notifyTutorialDelegateOfNewIndex()
    
    
  }
  
}

protocol TutorialPageViewControllerDelegate: class {
  
  /**
   Called when the number of pages is updated.
   
   - parameter tutorialPageViewController: the TutorialPageViewController instance
   - parameter count: the total number of pages.
   */
  func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageCount count: Int)
  /**
   Called when the current index is updated.
   
   - parameter tutorialPageViewController: the TutorialPageViewController instance
   - parameter index: the index of the currently visible page.
   */
  func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageIndex index: Int)
  
}
