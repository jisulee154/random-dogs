//
//  TabManViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/06/16.
//

import Foundation
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstTabVC") as! FirstTabViewController
        let secondVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondTabVC") as! SecondTabViewController
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .black
        // tap center
        bar.layout.alignment = .centerDistributed
        // tap 사이 간격
        bar.layout.interButtonSpacing = 12
        // tap 선택 / 미선택
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

//MARK: - Tabman DataSource
extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        if index == 0 {
            item.title = "Get a dog"
        } else if index == 1 {
            item.title = "Gallery"
        } else {
            item.title = "Page \(index+1)"
        }
        item.image = UIImage(named: "image.png") // ??
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
