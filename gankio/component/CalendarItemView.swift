//
//  CalendarItemView.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

@IBDesignable class CalendarItemView: XibBirdgeView {
    
    @IBInspectable var days: String? {
        didSet {
            update()
        }
    }
    
    @IBInspectable var week: String? {
        didSet {
            update()
        }
    }

    @IBInspectable var month: String? {
        didSet {
            update()
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            if (oldValue == isSelect) {
                return
            }
            let selectedColor = UIColor(red: 0.2, green: 0.5, blue: 0.6, alpha: 1.0)
            let unselectColor = UIColor.gray
            weekLabel.textColor = isSelect ? selectedColor : unselectColor
            daysLabel.textColor = isSelect ? selectedColor : unselectColor
            monthLabel.textColor = isSelect ? selectedColor : unselectColor
        }
    }
    
    var date: Date? {
        didSet {
            if date == nil {
                days = nil
                week = nil
                month = nil
                return
            }
            let timeZone = TimeZone(identifier: "CCT") ?? TimeZone.current
            let dateComponents = Calendar.current.dateComponents(in: timeZone, from: date!)
            let dayOfMonth = dateComponents.day ?? 0
            let hour = dateComponents.hour
            let mins = dateComponents.minute
            month = Month(rawValue: dateComponents.month!)?.description
            days = dayOfMonth < 10 ? "0\(dayOfMonth)" : String(dayOfMonth)
            week = Week(rawValue: dateComponents.weekday!)?.description
        }
    }
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func update() {
        daysLabel?.text = days
        weekLabel?.text = week
        monthLabel?.text = month
    }
    
    func size() -> CGSize {
        let rect1 = daysLabel?.textRect(forBounds: daysLabel.frame, limitedToNumberOfLines: 1) ?? CGRect.zero
        let rect2 = weekLabel?.textRect(forBounds: weekLabel.frame, limitedToNumberOfLines: 1) ?? CGRect.zero
        let rect3 = monthLabel?.textRect(forBounds: monthLabel.frame, limitedToNumberOfLines: 1) ?? CGRect.zero
        let width = rect1.width + rect2.width + 25
        let height = rect1.height + rect3.height + 25
        return CGSize(width: width, height: height)
    }
    
    enum Week: Int {
        case SATURDAY
        case SUNDAY
        case MONDAY
        case TUESDAY
        case WEDNESDAY
        case THURSDAY
        case FRIDAY
        
        var description: String {
            get {
                switch self {
                case .SUNDAY:
                    return "周日"
                case .MONDAY:
                    return "周一"
                case .TUESDAY:
                    return "周二"
                case .WEDNESDAY:
                    return "周三"
                case .THURSDAY:
                    return "周四"
                case .FRIDAY:
                    return "周五"
                case .SATURDAY:
                    return "周六"
                }
            }
        }
    }
    
    enum Month: Int {
        case JANUARY = 1
        case FEBRUARY
        case MARCH
        case APRIL
        case MAY
        case JUNE
        case JULY
        case AUGUST
        case SEPTEMBER
        case OCTOBER
        case NOVEMBER
        case DECEMBER
        
        var description: String {
            switch self {
            case .JANUARY:
                return "一月"
            case .FEBRUARY:
                return "二月"
            case .MARCH:
                return "三月"
            case .APRIL:
                return "四月"
            case .MAY:
                return "五月"
            case .JUNE:
                return "六月"
            case .JULY:
                return "七月"
            case .AUGUST:
                return "八月"
            case .SEPTEMBER:
                return "九月"
            case .OCTOBER:
                return "十月"
            case .NOVEMBER:
                return "十一月"
            case .DECEMBER:
                return "十二月"
            }
        }
    }
}
