
import UIKit

public class NumberIndicator: UIView {
    
    public static var DEFAULT_INDEX = 0
    
    public static var DEFAULT_COUNT = 0
    
    public static var DEFAULT_SEPARATOR = "/"
    
    public static var DEFAULT_GAP: CGFloat = 5
    
    public static var DEFAULT_TEXT_SIZE: CGFloat = 14
    
    public static var DEFAULT_TEXT_COLOR = UIColor.white
    
    // 当前页
    public var index = -1 {
        didSet {
            indexView.text = "\(index)"
        }
    }
    
    // 总页数
    public var count = -1 {
        didSet {
            countView.text = "\(count)"
        }
    }
    
    // 分隔符
    public var separator = "" {
        didSet {
            separatorView.text = separator
        }
    }
    
    // 分隔符与 index count 的间距
    public var gap: CGFloat = 0 {
        didSet {
            separatorLeftConstraint.constant = gap
            separatorRightConstraint.constant = gap
            setNeedsLayout()
        }
    }
    
    // 文本字号
    public var textSize: CGFloat = 0 {
        didSet {
            let font = UIFont.systemFont(ofSize: textSize)
            indexView.font = font
            countView.font = font
            separatorView.font = font
        }
    }
    
    // 文本颜色
    public var textColor = UIColor.white {
        didSet {
            indexView.textColor = textColor
            countView.textColor = textColor
            separatorView.textColor = textColor
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(
            width: indexView.intrinsicContentSize.width + gap + separatorView.intrinsicContentSize.width + gap + countView.intrinsicContentSize.width,
            height: indexView.intrinsicContentSize.height
        )
    }

    private lazy var indexView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()
    
    private lazy var separatorView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()
   
    private lazy var countView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()
    
    private lazy var separatorLeftConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: separatorView, attribute: .left, relatedBy: .equal, toItem: indexView, attribute: .right, multiplier: 1, constant: 0)
    }()
    
    private lazy var separatorRightConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: separatorView, attribute: .right, relatedBy: .equal, toItem: countView, attribute: .left, multiplier: 1, constant: 0)
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = .clear
        
        addConstraints([
            
            NSLayoutConstraint(item: indexView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: indexView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: countView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: countView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            
            separatorLeftConstraint,
            separatorRightConstraint,
            NSLayoutConstraint(item: separatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            
        ])
        
        gap = NumberIndicator.DEFAULT_GAP
        
        index = NumberIndicator.DEFAULT_INDEX
        count = NumberIndicator.DEFAULT_COUNT
        separator = NumberIndicator.DEFAULT_SEPARATOR
        
        textSize = NumberIndicator.DEFAULT_TEXT_SIZE
        textColor = NumberIndicator.DEFAULT_TEXT_COLOR
        
    }
    
}
