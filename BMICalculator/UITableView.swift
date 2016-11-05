import UIKit

extension UITableView {
    func height(forRowCount count: Int) -> CGFloat {
        var tableViewHeight: CGFloat = 0
        
        for index in 0..<count {
            let cellRect = rectForRow(at: IndexPath(row: index, section: 0))
            print(cellRect)
            tableViewHeight += cellRect.height
        }
        
        return tableViewHeight
    }
}
