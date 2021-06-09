import UIKit

protocol PaletteDelegate: class {
    func paintBrushDidChange(color: UIColor)
}

//ColorPalette
class Palette: UIView {
    
    //Declarations
    let colors: [UIColor]
    let theme: Theme
    
    //stackView for colors
    let stackView = UIStackView()
    
    weak var delegate: PaletteDelegate?
    
    //init
    init(colors: [UIColor], theme: Theme) {
        self.colors = colors
        self.theme = theme
        
        super.init(frame: CGRect(
            x: 0,
            y: 0,
            width: Metrics.regular + 10,
            height: CGFloat(colors.count) * Metrics.regular + CGFloat(colors.count) + 10
            )
        )
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    
    
    func setupViews() {
        
        //background
        backgroundColor = theme.accentColor
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        //adding colors
        for (index, color) in colors.enumerated() {
            let button = UIButton()
            button.backgroundColor = color
            button.layer.borderWidth = 1
            button.layer.borderColor = index == 0 ? theme.paletteSelected.cgColor : theme.paletteDefault.cgColor
            button.addTarget(self, action: #selector(handleColorSelected(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        addSubview(stackView)
        
        stackView.frame = CGRect(
            x: 5,
            y: 5,
            width: bounds.width - 10,
            height: bounds.height - 10
        )
    }
    
    @objc func handleColorSelected(sender: UIButton) {
        stackView.arrangedSubviews.forEach { (view) in
            view.layer.borderColor = theme.paletteDefault.cgColor
        }
        sender.layer.borderColor = theme.paletteSelected.cgColor
        delegate?.paintBrushDidChange(color: sender.backgroundColor!)
    }
}


