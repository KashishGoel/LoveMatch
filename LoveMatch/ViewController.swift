//
//  ViewController.swift
//  LoveMatch
//
//  Created by Kashish Goel on 2015-07-25.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit
    let pageController = ViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)

class ViewController: UIPageViewController, UIPageViewControllerDataSource{
    let cardsVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navCards") as! UIViewController
    let profileVC:UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navProfile") as! UIViewController
    let matchesVC:UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navMatches") as! UIViewController
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.dataSource = self
        self.setViewControllers([cardsVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
//reqd funcs
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case cardsVC:
            return matchesVC
        case profileVC:
            return cardsVC
            
        default:
            return nil
       }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case cardsVC:
            return profileVC
        case profileVC:
            return nil
        case matchesVC:
            return cardsVC
        default:
            return nil
        
        }
     
        
    }
    
    func goToNextVC () {
    let nextVC = pageViewController(self, viewControllerAfterViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([nextVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func goToPreviousVC () {
    let previousVC = pageViewController(self, viewControllerBeforeViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([previousVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
        setViewControllers([previousVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }
    
}

