//
//  SelectionViewDataSource.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//
import UIKit

protocol SelectionViewDataSource: AnyObject {
    func numberOfCell(_ selectionView: SelectionView) -> Int
    func colorForIndicator(_ selectionView: SelectionView) -> UIColor
    func selectionView(_ selectionView: SelectionView, titleForCellAt: Int) -> String
    func selectionView(_ selectionView: SelectionView, colorForTitleAt: Int) -> UIColor
    func selectionView(_ selectionView: SelectionView, fontForTitleAt: Int)  -> UIFont
}

extension SelectionViewDataSource {
    func numberOfCell(_ selectionView: SelectionView) -> Int {
        return 2
    }
    
    func colorForIndicator(_ selectionView: SelectionView) -> UIColor {
        return UIColor.blue
    }
    
    func selectionView(_ selectionView: SelectionView, colorForTitleAt: Int) -> UIColor {
        return UIColor.white
    }
    
    func selectionView(_ selectionView: SelectionView, fontForTitleAt: Int) -> UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
}
