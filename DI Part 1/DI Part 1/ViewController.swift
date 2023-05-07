//
//  ViewController.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//

import UIKit

struct ButtonModel {
    let color: UIColor
    let title: String
}

class ViewController: UIViewController {
    let topSource = [
        ButtonModel(color: .red, title: "Red"),
        ButtonModel(color: .yellow, title: "Yellow")
    ]
    
    let bottomSource = [
        ButtonModel(color: .red, title: "Red"),
        ButtonModel(color: .yellow, title: "Yellow"),
        ButtonModel(color: .blue, title: "Blue")
    ]
    
    @IBOutlet weak var firstSelectionView: SelectionView! {
        didSet {
            firstSelectionView.delegate = self
            firstSelectionView.dataSource = self
        }
    }
    @IBOutlet weak var firstColorView: UIView!
    @IBOutlet weak var secondSelectionView: SelectionView! {
        didSet {
            secondSelectionView.delegate = self
            secondSelectionView.dataSource = self
        }
    }
    @IBOutlet weak var secondColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: SelectionViewDelegate {
    func selectionView(_ selectionView: SelectionView, shouldCellSelect: Int) -> Bool {
        if selectionView == firstSelectionView {
            return true
        } else {
            return firstColorView.backgroundColor !== topSource.last?.color
        }
    }
    
    func selectionView(_ selectionView: SelectionView, didSelectCellAt: Int) {
        if selectionView == firstSelectionView {
            self.firstColorView.backgroundColor = topSource[didSelectCellAt].color
        } else {
            self.secondColorView.backgroundColor = bottomSource[didSelectCellAt].color
        }
    }
}

extension ViewController: SelectionViewDataSource {
    func numberOfCell(_ selectionView: SelectionView) -> Int {
        if selectionView == firstSelectionView {
            return topSource.count
        } else {
            return bottomSource.count
        }
    }
    
    func colorForIndicator(_ selectionView: SelectionView) -> UIColor {
        return UIColor.white
    }
    
    func selectionView(_ selectionView: SelectionView, titleForCellAt: Int) -> String {
        if selectionView == firstSelectionView {
            return topSource[titleForCellAt].title
        } else {
            return bottomSource[titleForCellAt].title
        }
    }
    
    func selectionView(_ selectionView: SelectionView, fontForTitleAt: Int) -> UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
}
