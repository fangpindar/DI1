//
//  SelectionView.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//
import UIKit
import UIKit

class SelectionView: UIView {
    weak var dataSource: SelectionViewDataSource? {
        didSet {
            self.initView()
        }
    }
    weak var delegate: SelectionViewDelegate? {
        didSet {
            self.initView()
        }
    }
    
    var indicatorView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        resetSelectionView()
        
        guard let numberOfCell = self.dataSource?.numberOfCell(self) else { return }
        
        let viewWidth = Int(self.frame.width)
        let viewHeight = Int(self.frame.height)
        let cellWidth = viewWidth / numberOfCell
        
        doSetCells(viewHeight: viewHeight, cellWidth: cellWidth, numberOfCell: numberOfCell)
        
        self.delegate?.selectionView?(self, didSelectCellAt: 0)
    }
    
    private func resetSelectionView() {
        self.backgroundColor = .black
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func doSetCells(viewHeight: Int, cellWidth: Int, numberOfCell: Int) {
        for index in 0..<numberOfCell {
            
            guard let selectionViewCell = Bundle(for: SelectionViewCell.self).loadNibNamed("SelectionViewCell", owner: self, options: nil)?.first as? SelectionViewCell else { return }
            
            selectionViewCell.frame = CGRect(x: cellWidth * index, y: 0, width: cellWidth, height: viewHeight - 1)
            
            selectionViewCell.colorButton?.setTitle(self.dataSource?.selectionView(self, titleForCellAt: index), for: .normal)
            
            selectionViewCell.colorButton?.setTitleColor(self.dataSource?.selectionView(self, colorForTitleAt: index), for: .normal)
            
            selectionViewCell.colorButton?.titleLabel?.font = self.dataSource?.selectionView(self, fontForTitleAt: index)
            
            selectionViewCell.colorButton?.tag = index
            
            selectionViewCell.colorButton?.addTarget(self, action: #selector(doCellClick), for: .touchUpInside)
            
            self.addSubview(selectionViewCell)
            
            if index == 0 {
                let centerX = selectionViewCell.frame.origin.x + selectionViewCell.frame.width / 4
                self.indicatorView = UIView(frame: CGRect(x: Int(centerX), y: viewHeight - 2, width: Int(selectionViewCell.frame.width) / 2, height: 2))
                
                self.indicatorView!.backgroundColor = self.dataSource?.colorForIndicator(self)
                
                self.addSubview(indicatorView!)
            }
        }
    }
    
    @objc private func doCellClick(_ sender : UIButton) {
        guard let shouldCellSelect = self.delegate?.selectionView?(self, shouldCellSelect: sender.tag) else { return  }
        
        if shouldCellSelect {
            self.delegate?.selectionView?(self, didSelectCellAt: sender.tag)
            self.moveIndicatorView(reference: sender)
        }
    }
    
    private func moveIndicatorView(reference: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            let referenceSuperView = reference.superview!.superview!
            let centerX = referenceSuperView.frame.origin.x + referenceSuperView.frame.width / 4
            self?.indicatorView?.frame.origin.x = centerX
            
            self?.layoutIfNeeded()
        })
    }
}
