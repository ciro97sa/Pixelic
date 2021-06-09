import UIKit

//MARK : SketchDelegate
protocol SketchDelegate: class {
    func colorChanged(newPixelState pixelState: PixelState)
    func clearSketch()
}

public struct SketchState {
    let state: Set<PixelState>
}

//MARK : pixelState struct
public struct PixelState: Hashable {
    let x: Int
    let y: Int
    let color: UIColor
    
    public var hashValue: Int {
        return "\(x)\(y)\(color)".hashValue
    }
    
    
    public static func == (lhs : PixelState, rhs : PixelState) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.color == rhs.color
    }
}

struct SketchViewModel {
    
    //variables definition
    private var stateHistory: Array<SketchState>
    private var currentDraw: Set<PixelState>
    private var undoneChanges: Array<SketchState>
    
    //delegate
    weak var delegate: SketchDelegate?
    
    //init
    init(initialState: SketchViewModel? = nil) {
        stateHistory = []
        currentDraw = []
        undoneChanges = []
    }
    
    //MARK : func drawAt
    mutating func drawAt(x: Int, y: Int, color: UIColor) {
        let pixelState = PixelState(x: x, y: y, color: color)
        let (inserted, _) = currentDraw.insert(pixelState)
        if inserted {
            undoneChanges = []
            delegate?.colorChanged(newPixelState: pixelState)
        }
    }
    
    mutating func endDrawing() {
        stateHistory.append(SketchState(state: currentDraw))
        currentDraw = []
    }
    
    struct Point: Hashable {
        let x: Int
        let y: Int
        
        public var hashValue: Int {
            return "\(x),\(y)".hashValue
        }
        
        public static func == (lhs: Point, rhs: Point) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
    
    //MARK : undo()
    mutating func undo() {
        guard let lastDraw = stateHistory.popLast() else { return }
        
        delegate?.clearSketch()
        for state in stateHistory {
            apply(sketchState: state)
        }
        undoneChanges.append(lastDraw)
    }
    
    //MARK : redo()
    mutating func redo() {
        guard let lastUndoneDraw = undoneChanges.popLast() else { return }
        apply(sketchState : lastUndoneDraw)
        stateHistory.append(lastUndoneDraw)
    }
    
    mutating func apply(sketchState : SketchState) {
        for pixelState in sketchState.state {
            delegate?.colorChanged(newPixelState : pixelState)
        }
    }
}


