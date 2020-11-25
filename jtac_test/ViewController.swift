//
//  ViewController.swift
//  jtac_test
//
//  Created by Sergey on 24.11.2020.
//

import UIKit
import JTAppleCalendar


class ViewController: UIViewController {

    var formatter = DateFormatter()
    var calendar = Calendar.current
    
    
    @IBOutlet weak var calendarView: JTACMonthView!
    
    
    override func viewDidLoad() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func handleCellConfiguration(cell: JTACDayCell?, cellState: CellState) {
        handleCellTextColor(veiw: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellTextColor(veiw: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CustomCell else { return }
        if cellState.isSelected {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        } else {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CustomCell else {return }
//        switch cellState.selectedPosition() {
//        case .full:
//            myCustomCell.backgroundColor = .green
//        case .left:
//            myCustomCell.backgroundColor = .yellow
//        case .right:
//            myCustomCell.backgroundColor = .red
//        case .middle:
//            myCustomCell.backgroundColor = .blue
//        case .none:
//            myCustomCell.backgroundColor = nil
//        }
        
        if cellState.isSelected {
            myCustomCell.isSelectedView.layer.cornerRadius =  13
            myCustomCell.isSelectedView.frame.size = myCustomCell.frame.size
            myCustomCell.isSelectedView.isHidden = false
        } else {
            myCustomCell.isSelectedView.isHidden = true
        }
    }
    

}

extension ViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func configureCell(cell: JTACDayCell, cellState: CellState, date: Date, indexPath: IndexPath) {
        guard let cell = cell as? CustomCell else {return}
        cell.dateLabel.text = cellState.text
        if calendar.isDateInToday(date) {
            cell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else {
            cell.dateLabel.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
        
        handleCellConfiguration(cell: cell, cellState: cellState)
        
    }
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
    
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = Date()
        let parametrs = ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: 6,
            calendar: .current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfRow,
            firstDayOfWeek: .monday,
            hasStrictBoundaries: true)
        return parametrs
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(cell: cell, cellState: cellState, date: date, indexPath: indexPath)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        //cell.dateLabel.text = cellState.text
        configureCell(cell: cell, cellState: cellState, date: date, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    
    
    
}

