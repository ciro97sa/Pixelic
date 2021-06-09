import UIKit


public class Sketch: UIView {
    //Sketch class is a container of Pixels
    class Pixel: UIView {}
    
    //declarations
    var pixels: Array<Array<Pixel>>!
    var width: Int
    var height: Int
    var pixelSize: CGFloat
    let sketchDefaultColor: UIColor
    public var paintBrushColor = UIColor.black
    var viewModel: SketchViewModel
    var lastTouched = Set<Pixel>()
    
    //init
    public init(width: Int, height: Int, pixelSize: CGFloat, sketchColor: UIColor) {
        self.width = width
        self.height = height
        self.pixelSize = pixelSize
        sketchDefaultColor = sketchColor
        viewModel = SketchViewModel()
        
        super.init(frame: CGRect(x: 0, y: 0, width:  CGFloat(width) * pixelSize, height: CGFloat(height) * pixelSize))
        viewModel.delegate = self
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
    
    //MARK : setupView()
    private func setupView() {
        
        //Gestures
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDrag(sender:)))
        tapGestureRecognizer.delegate = self
        let dragGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleDrag(sender:)))
        dragGestureRecognizer.minimumPressDuration = 0
        addGestureRecognizer(dragGestureRecognizer)
        //creating the Sketch
        pixels = []
        for heightIndex in 0..<height {
            pixels.append([])
            for widthIndex in 0..<width {
                let pixel = createPixel(defaultColor : sketchDefaultColor)
                pixel.frame = CGRect(
                    x: CGFloat(widthIndex) * pixelSize,
                    y: CGFloat(heightIndex) * pixelSize,
                    width: pixelSize,
                    height: pixelSize
                )
                pixels[heightIndex].append(pixel)
                addSubview(pixel)
            }
        }
        isUserInteractionEnabled = true
    }
    
    
    //MARK : createPixel()
    private func createPixel(defaultColor: UIColor) -> Pixel {
        let pixel = Pixel()
        pixel.backgroundColor = defaultColor
        pixel.layer.borderWidth = 0.5
        pixel.layer.borderColor = UIColor.lightGray.cgColor
        pixel.isUserInteractionEnabled = false
        return pixel
    }
    
    //MARK : handleDrag() function to use for gestures
    @objc private func handleDrag(sender: UIGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            draw(atPoint: sender.location(in: self))
        case .ended:
            draw(atPoint: sender.location(in: self))
            viewModel.endDrawing()
        default: break
        }
    }
    
    //MARK : func draw()
    private func draw(atPoint point: CGPoint) {
        if saveLabel.isHidden == false {
            saveLabel.isHidden = true
        }
        let y = Int(point.y / pixelSize)
        let x = Int(point.x / pixelSize)
        guard y < height && x < width && y >= 0 && x >= 0 else { return }
        viewModel.drawAt(x: x, y: y, color: paintBrushColor)
    }
    
    //MARK : removeGrid()
    //function used to save the image without grids.
    private func removeGrid() {
        for row in pixels {
            for pixel in row {
                pixel.layer.borderWidth = 0
            }
        }
    }
    
    //MARK : addGrid() fuction
    private func addGrid() {
        for row in pixels {
            for pixel in row {
                pixel.layer.borderWidth = 0.5
            }
        }
    }
    
    //MARK : makeImageFromSelf() function
    //function used to create the image to save in photos.
    func makeImageFromSelf() -> UIImage {
        removeGrid()
        UIGraphicsBeginImageContext(self.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        addGrid()
        return image!
    }
}

//MARK : Sketch extension

extension Sketch : SketchDelegate {
    
    func colorChanged(newPixelState pixelState: PixelState) {
        pixels[pixelState.y][pixelState.x].backgroundColor = pixelState.color
    }
    
    //MARK : clearSketch() function
    public func clearSketch() {
        for row in pixels {
            for pixel in row {
                pixel.backgroundColor = sketchDefaultColor
            }
        }
    }
}

extension Sketch : UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

