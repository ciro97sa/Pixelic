import UIKit
import PlaygroundSupport


public class Workspace : UIView {
    
    public let arrayOfIcons = DataModel.shared.arrayOfIcons
    
    // class members
     let sketch : Sketch
     let palette : Palette
     let controlCenter : SketchControlCenter
     var width : Int
     var height : Int
     var pixelSize : CGFloat
     let colors : Array<UIColor>
     let theme : Theme
    
    static var numberOfSaves : Int = 0
    
    //from PaletteDelegate
    public var currentPaintBrush : UIColor = .black {
        didSet {
            sketch.paintBrushColor = currentPaintBrush
        }
    }

    //flowLayout for CollectionView
    lazy var flowLayout : UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        return flow
        }()
    
    //Public init required to setup all variables
    public init(width : Int, height : Int, pixelSize : CGFloat, sketchColor : UIColor, colorPalette : [UIColor], theme : Theme) {
        self.width = width
        self.height = height
        self.pixelSize = pixelSize
        self.colors = colorPalette.filter{ $0 != sketchColor } + [sketchColor]
        self.theme = theme
        sketch = Sketch(width : width, height : height, pixelSize : pixelSize, sketchColor : sketchColor)
        palette = Palette(colors : colors, theme : theme)
        controlCenter = SketchControlCenter(theme : theme)
        
        super.init(frame : CGRect(
            x: 0,
            y: 0,
            width:  max(controlCenter.bounds.width + palette.bounds.width + Metrics.regular * 4 + 100, CGFloat(width) * pixelSize + Metrics.regular * 4),
            height: max(sketch.bounds.height + controlCenter.bounds.height + Metrics.regular * 3 + 150, palette.bounds.height + Metrics.regular * 2)))
        
        setupViews()
    }
    
    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK : setupViews in Workspace
    func setupViews() {
        if let startingPaintBrush = self.colors.first {
            currentPaintBrush = startingPaintBrush
        }
        
        //background
        backgroundColor = theme.mainColor
        
        //delegates
        palette.delegate = self
        controlCenter.delegate = self
        
        // set collection View
        let cv = UICollectionView(frame: CGRect(x : 5, y : 5, width : width*Int(pixelSize) , height : 125),collectionViewLayout : flowLayout)
        cv.backgroundColor = theme.accentColor
        cv.setCollectionViewLayout(self.flowLayout, animated: true)
        cv.register(collectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        
        //Creating Save View
        let saveView = UIView(frame : CGRect(x : sketch.bounds.width - Metrics.large * 3, y : sketch.bounds.height + Metrics.regular * 4+10,width: Metrics.large * 3 + 10 ,height: Metrics.large + 10))
        saveView.backgroundColor = theme.mainColor
        saveView.addSubview(saveLabel)
        saveLabel.font = UIFont.boldSystemFont(ofSize: saveLabel.font.pointSize)
        saveLabel.text = ""
        saveLabel.textAlignment = .center
        saveLabel.textColor = theme.accentColor
        saveLabel.isHidden = true
        
        // Origin
        setSketchOrigin()
        setPaletteOrigin()
        setControlCenterOrigin()
        
        //Subviews
        addSubview(sketch)
        addSubview(palette)
        addSubview(controlCenter)
        addSubview(cv)
        addSubview(saveView)
        
        //Check for constraints
        if ((sketch.bounds.height + Metrics.regular*2 + 60) >= (UIScreen.main.bounds.height - cv.bounds.height - 70)) {
            cv.frame.origin = CGPoint(
                x: max(CGFloat(width) * pixelSize + 86, controlCenter.bounds.width + Metrics.regular * 2),
                y: Metrics.regular*3+10)
            cv.frame.size = CGSize(width : 125, height : height*Int(pixelSize))
            if let layout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
        }else if((sketch.bounds.width + Metrics.regular*2+60) >= (UIScreen.main.bounds.width)) {
            cv.frame.origin = CGPoint(
                x: Metrics.regular,
                y: sketch.bounds.height + Metrics.regular*7 + 10)
            if let layout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            } else {
        cv.frame.origin = CGPoint(
                x: Metrics.regular,
                y: sketch.bounds.height + Metrics.regular*7 + 10)
        }
        
        
    }
    
    
    //MARK : setSketchOrigin()
    func setSketchOrigin(){
        sketch.frame.origin = CGPoint(x : Metrics.regular , y : Metrics.regular*3+10)
    }
    
    //MARK : setPaletteOrigin()
    func setPaletteOrigin(){
        palette.frame.origin = CGPoint(
            x: max(CGFloat(width) * pixelSize + 40, controlCenter.bounds.width + Metrics.regular * 2),
            y: Metrics.regular*3+10
        )
    }
    //MARK : setControlCenterOrigin()
    func setControlCenterOrigin(){
        controlCenter.frame.origin = CGPoint(
            x: Metrics.regular,
            y: sketch.bounds.height + Metrics.regular*4+10)
    }
}

extension Workspace : PaletteDelegate {
    
    func paintBrushDidChange(color : UIColor) {
        currentPaintBrush = color
    }
}

extension Workspace : SketchControlCenterDelegate {
    
    //MARK : redoPressed()
    func redoPressed() {
        sketch.viewModel.redo()
    }
    
    //MARK : undoPressed()
    func undoPressed() {
        if saveLabel.isHidden == false {
            saveLabel.isHidden = true
        }
        sketch.viewModel.undo()
        
    }
    
    //MARK : savePressed()
    func savePressed() {
        let image = sketch.makeImageFromSelf()
        do {
            guard let image = UIImagePNGRepresentation(image) else {
                return print("Couldn't get image from current context")
            }
            let compressedimage = UIImage(data : image)
            UIImageWriteToSavedPhotosAlbum(compressedimage!, nil, nil, nil)
            saveLabel.isHidden = false
            sleep(2)
            print("Save successful!")
            saveLabel.text = "Icon saved!"
            }
        
    }

    
}


