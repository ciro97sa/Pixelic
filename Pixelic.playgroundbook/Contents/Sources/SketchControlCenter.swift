import UIKit

//MARK : SketchControlCenter protocol

protocol SketchControlCenterDelegate: class {
    func undoPressed()
    func redoPressed()
    func savePressed()
}

class SketchControlCenter: UIView {
    //declarations
    let theme: Theme
    weak var delegate: SketchControlCenterDelegate?
    
    //init
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: CGRect(x: 0, y: 0, width:  Metrics.large * 3 + 10, height: Metrics.large + 10))
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
        
        //stackView for buttons
        
        let stackView = UIStackView(frame: CGRect(x: 5, y: 5, width: Metrics.large * 3, height: Metrics.large))
        
        //Stack properties
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        //buttons
        let undoButton = UIButton()
        undoButton.setTitle("↩️", for: .normal)
        undoButton.addTarget(self, action: #selector(undoButtonPressed), for: .touchUpInside)
        
        let redoButton = UIButton()
        redoButton.setTitle("↪️", for: .normal)
        redoButton.addTarget(self, action: #selector(redoButtonPressed), for: .touchUpInside)

        let saveButton = UIButton()
        saveButton.setTitle("💾", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        //Add in stackView
        stackView.addArrangedSubview(undoButton)
        stackView.addArrangedSubview(redoButton)
        stackView.addArrangedSubview(saveButton)
    }
    
    
    @objc func undoButtonPressed() {
        delegate?.undoPressed()
    }
    
    @objc func redoButtonPressed() {
        delegate?.redoPressed()
    }
    
    @objc func saveButtonPressed() {
        delegate?.savePressed()
    }
    
}

