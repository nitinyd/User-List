//
//  CustomPageVC.swift
//  User List
//
//  Created by Nitin Yadav on 7/3/2021.
//

import UIKit

class CustomPageVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedVCs.first {
                setViewControllers([firstViewController],
                                   direction: .reverse,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    private(set) lazy var orderedVCs: [UIViewController] = {
        return [self.newViewController(vc: "UserListVC"),
                self.newViewController(vc: "AddUserVC")
        ]
    }()
    
}

extension CustomPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVCs.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedVCs.count > previousIndex else {
            return nil
        }
        
        return orderedVCs[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVCs.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        let orderedViewControllersCount = orderedVCs.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedVCs[nextIndex]
    }

    private func newViewController(vc: String) -> UIViewController {
        
        if vc == "AddUserVC" {
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "addUserVC")
        }
        else {
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "userListVC")
        }
    }
}
