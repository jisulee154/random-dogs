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
    @IBOutlet weak var tempView: UIView! // 상단 탭바 들어갈 자리

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

        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let tabmanVC = storyboard?.instantiateViewController(withIdentifier: "TabManVC") {
//            viewControllers.append(tabmanVC)
//        }
//        if let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstTabVC") {
//            viewControllers.append(firstVC)
//        }
//        self.dataSource = self
//
//        let bar = TMBar.ButtonBar()
//        bar.layout.transitionStyle = .snap
//        // tab 밑 bar 색깔 & 크기
//        bar.indicator.weight = .custom(value: 1)
//        bar.indicator.tintColor = .black
//        // tap center
//        bar.layout.alignment = .centerDistributed
//        // tap 사이 간격
//        bar.layout.interButtonSpacing = 12
//        // tap 선택 / 미선택
//        bar.buttons.customize { (button) in
//            button.tintColor = .gray
//            button.selectedTintColor = .black
//            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
//        }
//
//        // bar를 안보이게 하고 싶으면 addBar를 지우면 된다. at -> bar 위치
//        addBar(bar, dataSource: self, at: .bottom)
//    }
}

//MARK: - Tabman DataSource
extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
            let item = TMBarItem(title: "")
            item.title = "Page \(index)"
            item.image = UIImage(named: "image.png")
            // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
            
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
