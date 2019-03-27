//
//  Const.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
//import Foundation
import SpriteKit

extension SKSpriteNode {
    var yAxis:CGFloat {
        set {
            position.y = newValue
        }
        get {
            return position.y
        }
    }
    var xAxis:CGFloat {
        set {
            position.x = newValue
        }
        get {
            return position.x
        }
    }
}
let LandFragment:Array<Array<CGFloat>> = [
    [0,0,1,0,0,2,2,2],
    [1,0,2,0,0,1,2,2],
    [0,0,2,0,0,1,2,2],
    [0,1,1,1,0,2],
    [0,0,0,1,1,1],
    [0,0,1,2,2,2],
    [1,1,2,1,2,2],
    [2,0,2,1,0,2],
    [0,0,2,1,1,2,2,2],
    [2,0,0,1,0,2,1,2],
    [0,0,2,1,0,2,1,2],
    [0,0,2,0,0,1,1,2],
]
struct Quality {
    static let NORMAL = 1
    static let GOOD = 2
    static let RARE = 3
    static let SACRED = 4
}

struct EvilType {
    static let RISEN = 1
    static let MAN = 2
    static let ANGEL = 3
    static let DEMON = 4
    static let NATURE = 5
    static let FINAL = 6
    static func getTypeLabel(type:Int) -> String {
        switch type {
        case EvilType.RISEN:
            return "亡灵"
        case EvilType.ANGEL:
            return "天使"
        case EvilType.MAN:
            return "人类"
        case EvilType.NATURE:
            return "生灵"
        case EvilType.DEMON:
            return "恶魔"
        default:
            return "人类"
        }
    }
}

struct TypeName {
    static let RISEN = "亡灵"
    static let ANGEL = "天使"
    static let MAN = "人类"
    static let NATURE = "生物"
    static let DEMON = "噩梦"
    static func getName(_ type: Int) -> String {
        switch type {
        case EvilType.RISEN:
            return RISEN
        case EvilType.ANGEL:
            return ANGEL
        case EvilType.MAN:
            return MAN
        case EvilType.NATURE:
            return NATURE
        case EvilType.DEMON:
            return DEMON
        default:
            return MAN
        }
    }
}
struct EvilName {
    static let VirulentToad = "剧毒蟾蜍"
    static let Mummy = "木乃伊"
    static let Slime = "史莱姆"
}
struct EvilImage {
    static let Mummy = "mummy.png"
    static let Slime = "slime.png"
}
struct EvilId {
    static let Mummy = 1
    static let Slime = 2
}
struct QualityColor {
    static let NORMAL = UIColor.white
    static let GOOD = UIColor.green
    static let RARE = UIColor.init(red: 0.2, green: 0.53, blue: 1, alpha: 1)
    static let SACRED = UIColor.init(red: 1, green: 0.137, blue: 0.137, alpha: 1)
    static func getColor(_ q:Int) -> UIColor {
        switch q {
        case Quality.NORMAL:
            return NORMAL
        case Quality.GOOD:
            return GOOD
        case Quality.RARE:
            return RARE
        case Quality.SACRED:
            return SACRED
        default:
            return NORMAL
        }
    }
}
struct Colors {
    static let STATUS_CHANGE = UIColor.orange
}
struct Element {
    static let FIRE = 1
    static let WATER = 2
    static let THUNFER = 3
}
struct DamageColor {
    static let DAMAGE = UIColor.init(red: 1, green: 0.137, blue: 0.137, alpha: 1)
    static let HEAL = UIColor.green
    static let NORMAL = UIColor.white
    static let FIRE = UIColor.orange
    static let WATER = UIColor.init(red: 0.2, green: 0.53, blue: 1, alpha: 1)
    static let THUNFER = UIColor.yellow
}
struct ElementColor {
    static let FIRE = UIColor.orange
    static let WATER = UIColor.init(red: 0.2, green: 0.53, blue: 1, alpha: 1)
    static let THUNFER = UIColor.yellow
    static func getColor(_ q:Int) -> UIColor {
        switch q {
        case Element.FIRE:
            return FIRE
        case Element.WATER:
            return WATER
        case Element.THUNFER:
            return THUNFER
        default:
            return FIRE
        }
    }
}
struct Block {
    static let OUTOFRANGE = -1
    static let PASSABLE = 0
    static let IMPASSABLE = 1
    static let TOUCHABLEITEM = 2
    static let EVIL = 3
    static let PASSABLEITEM = 4
    static let PORTAL = 5
}
struct Position {
    static let NORTH:Int = 0
    static let WEST:Int = 2
    static let EAST:Int = 1
    static let SOUTH:Int = 3
}
struct Mode {
    static let debug = true
    static let nocd = false
}
struct Cell {
    static func pot() -> SKTexture {
        return Game.instance.inside_b.getCell(9, 9)
    }
    static func pot_broken() -> SKTexture {
        return Game.instance.inside_b.getCell(10, 9)
    }
    static func bed() -> SKTexture {
        return Game.instance.inside_b.getCell(0, 11, 1, 2)
    }
    static func bed_broken() -> SKTexture {
        return Game.instance.inside_b.getCell(6, 11, 1, 2)
    }
}
class Documented:NSObject, NSCoding {
    override init() {
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_documents, forKey: "file")
        aCoder.encode(test, forKey: "tst")
    }

    required init?(coder aDecoder: NSCoder) {
        self._documents = aDecoder.decodeObject(forKey: "file") as! Array<Character>
        self.test = aDecoder.decodeObject(forKey: "tst") as! String
    }
    func insert(char:Character) {
        _documents.append(char)
    }
    func get(index:Int) -> Character {
        return _documents[index]
    }
    var test = "ssd"
    var _documents = Array<Character>()
}
//var c = 0
class Game {
    static let SELECTED_HIGHLIGH_COLOR = UIColor.init(red: 0.15, green: 0.87, blue: 1, alpha: 1)
    static let SELECTED_STROKE_WIDTH:CGFloat = 2
    static let UNSELECTED_STROKE_WIDTH:CGFloat = 1
    static let UNSELECTED_STROKE_COLOR = UIColor.white
    static let HPBAR_COLOR = UIColor.red
    static let EXPBAR_COLOR = UIColor.green
    static let CORNER_RADIUS:CGFloat = 3
    static let CELLSIZE:CGFloat = 72
    static let ICON_GAP:CGFloat = 12
    static let FRAME_SIZE:CGFloat = 0.3
    static let instance = Game()
    var stage:UIStage!
    var scene:GameScene!
    var role:BUnit!
    var char:Character!
    var curStage:MyStage!
    var document:Documented!
    var logs = ["你对他 造成了200点伤害", "你获取了灵魂宝典", "你收到了300点伤害"]
    var _size:CGFloat = 0
    var cellSize:CGFloat = 0
    var _fontSize:CGFloat = 0
    var frameSize:CGFloat = 0.3
    var screenWidth = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    var village:SKTexture = SKTexture(imageNamed: "village.tiff")
    var inside_a5:SKTexture = SKTexture(imageNamed: "Inside_A5.png")
    var inside_a4:SKTexture = SKTexture(imageNamed: "Inside_A4.png")
    var inside_a2:SKTexture = SKTexture(imageNamed: "Inside_A2.png")
    var inside_b:SKTexture = SKTexture(imageNamed: "Inside_B.png")
    var inside_c:SKTexture = SKTexture(imageNamed: "Inside_C.png")
    var outside_b:SKTexture = SKTexture(imageNamed: "Outside_B.png")
    var outside_c:SKTexture = SKTexture(imageNamed: "Outside_C.png")
    var outside_a5:SKTexture = SKTexture(imageNamed: "Outside_A5.png")
    var outside_a2:SKTexture = SKTexture(imageNamed: "Outside_A2.png")
    var outside_a1:SKTexture = SKTexture(imageNamed: "Outside_A1.png")
    var outside_a3:SKTexture = SKTexture(imageNamed: "Outside_A3.png")
    var outside_a4:SKTexture = SKTexture(imageNamed: "Outside_A4.png")
    var dungeon_a4:SKTexture = SKTexture(imageNamed: "Dungeon_A4.png")
    var dungeon_a2:SKTexture = SKTexture(imageNamed: "Dungeon_A2.png")
    var world_b:SKTexture = SKTexture(imageNamed: "World_B.png")
    var dungeon_b = SKTexture(imageNamed: "Dungeon_B.png")
    var dungeon_c = SKTexture(imageNamed: "Dungeon_C.png")
    var door2 = SKTexture(imageNamed: "Door2.png")
    var crystal = SKTexture(imageNamed: "Crystal.png")
    var sf_outside_c:SKTexture = SKTexture(imageNamed: "SF_Outside_C.png")
    var sf_outside_b:SKTexture = SKTexture(imageNamed: "SF_Outside_B.png")
    var sf_outside_a4:SKTexture = SKTexture(imageNamed: "SF_Outside_A4.png")
    var sf_outside_a5:SKTexture = SKTexture(imageNamed: "SF_Outside_A5.png")
    var sf_outside_a3:SKTexture = SKTexture(imageNamed: "SF_Outside_A3.png")
    var sf_inside_a4 = SKTexture(imageNamed: "SF_Inside_A4.png")
    var sf_inside_c = SKTexture(imageNamed: "SF_Inside_C.png")
    var tiled_dungeons:SKTexture = SKTexture(imageNamed: "TileD-Dungeons.png")
    var tilee_outsidetown:SKTexture = SKTexture(imageNamed: "TileE-OutsideTown.png")
    let sha = SKTexture(imageNamed: "sha3.png")
    var tile_innerTown = SKTexture(imageNamed: "TileE-InnerTown.png")
    var pictureMonster = SKTexture(imageNamed: "Monster.png")
    var pictureNature = SKTexture(imageNamed: "Nature.png")
    var pictureEvil = SKTexture(imageNamed: "Evil.png")
    var pictureBaldo = SKTexture(imageNamed: "BALDO.png")
    var pictureCollabo8_2 = SKTexture(imageNamed: "Collabo8_2.png")
    var pictureCollabo8_1 = SKTexture(imageNamed: "Collabo8_1.png")
    var pictureAll = SKTexture(imageNamed: "ALL.png")
    var pictureAll2 = SKTexture(imageNamed: "ALL2.png")
    var picturePeople2 = SKTexture(imageNamed: "People2.png")
    var picturePeople4 = SKTexture(imageNamed: "People4.png")
    var pictureVehicle = SKTexture(imageNamed: "Vehicle.png")
    var pictureActor1 = SKTexture(imageNamed: "Actor1.png")
    var pictureActor2 = SKTexture(imageNamed: "Actor2.png")
    var pictureActor3 = SKTexture(imageNamed: "Actor3.png")
    var picturePeople1 = SKTexture(imageNamed: "People1.png")
    var pictureChest = SKTexture(imageNamed: "Chest.png")
    private init() {
//        c += 1;
//        print(c)
        _size = 48
        _fontSize = _size * 0.25
        cellSize = 48
    }
    func sayHello() {
        print("hello!")
    }
    func loadTexture(completion:@escaping () -> Void) {
        let list = [village,
                    inside_b,
                    inside_a5,
                    inside_a4,
                    outside_b,
                    outside_c,
                    inside_c,
                    outside_a5,
                    outside_a2,
                    outside_a3,
                    outside_a4,
                    dungeon_a4,
                    dungeon_b,
                    dungeon_c,
                    sf_outside_c,
                    sf_outside_a4,
                    sf_outside_a3,
                    sf_inside_c,
                    tilee_outsidetown,
                    tiled_dungeons,
                    tile_innerTown,
                    picturePeople1,
                    pictureEvil,
                    pictureBaldo,
                    pictureNature,
                    pictureMonster,
                    pictureCollabo8_1,
                    pictureCollabo8_2,
                    pictureAll,
                    pictureAll2,
                    picturePeople2,
                    pictureActor1,
                    pictureActor2,
                    pictureActor3,
        ]
        SKTexture.preload(list) {
            completion()
        }

    }
    var _char:Character!
    static func createCloseButton() -> Button {
        let btn = Button()
        btn.text = "关闭"
        btn.position.x = Game.instance.cellSize * 6
        btn.position.y = Game.instance.cellSize * 3.5
        return btn
    }
    static func createMask() -> SKShapeNode {
        let width = Game.instance.screenWidth * 2
        let height = Game.instance.screenHeight * 2
        
        let bg0 = SKShapeNode(rect: CGRect(x: -width * 0.5, y: -height * 0.5, width: width, height: height))
        bg0.fillColor = UIColor.black
        bg0.alpha = 0.65
        bg0.lineWidth = 0
        return bg0
    }
    static func save() {
//        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/save.dat"
////        NSKeyedArchiver.archiveRootObject(Data.instance.document, toFile: path)
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver.init(forWritingWith: data)
//        archiver.encode(Game.instance.document, forKey: "save")
//        archiver.finishEncoding()
//        data.write(toFile: path, atomically: true)
    }
    static func load() {
//        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/save.dat"
//        let undata = NSData(contentsOfFile: path)
//        let unarchiver = NSKeyedUnarchiver.init(forReadingWith: undata! as Data)
//        let document = unarchiver.decodeObject(forKey: "save") as! Documented
//        Game.instance.document = document
//        let save = unarchiver.
//        NSKeyedArchiver.u
    }
    static func log(text:String) {
        Game.instance.logs.append(text)
        Game.instance.stage.showLogs()
    }
}
func debugger(_ text:String) {
    print(text)
}
func debug(_ text:String) {
    print(text)
//    let cellSize = Game.instance.cellSize
//    let node = SKSpriteNode()
//    var width = cellSize * 7
//    if text.count >= 15 {
//        width = width + ((text.count - 15) * 15).toFloat()
//    }
////    let rect = CGRect(x: -width * 0.5, y: cellSize * 4, width: width, height: cellSize * 0.5)
////    let bg = SKShapeNode(rect: rect, cornerRadius: 2)
////    bg.fillColor = UIColor.black
////    bg.alpha = 0.65
////    node.addChild(bg)
//
////    let border = SKShapeNode(rect: rect, cornerRadius: 2)
////    border.lineWidth = 1
////    node.addChild(border)
//
//    let l = Label()
//    l.fontSize = 14
//    l.fontColor = UIColor.white
//    l.text = text
//    l.position.y = cellSize * 4 - 20
//    node.addChild(l)
//
//    node.zPosition = 1500
//    let stage = Game.instance.stage!
//    stage._messageNode.removeFromParent()
//    stage._messageNode = node
//    //    node.isUserInteractionEnabled = true
//    stage.addChild(node)
//    setTimeout(delay: 3, completion: {
//        node.removeFromParent()
//        stage._messageNode = SKSpriteNode()
//    })
}
func node2texture(_ node:SKNode) -> SKTexture {
    let view = SKView()
    return view.texture(from: node)!
}
func createEvilById(_ id:Int) -> Creature {
    switch id {
    case EvilId.Mummy:
        return Mummy()
    case EvilId.Slime:
        return Slime()
    default:
        debug("evil id not found!")
    }
    
    return Creature()
}
func rand(min:Int = 0, max:Int = 101) -> Int {
    return Int(arc4random_uniform(UInt32(max + 1 - min))) + min
}
func setTimeout(delay:CGFloat, completion: @escaping () -> Void) {
    if delay <= 0 {
        completion()
        return
    }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(delay), execute: {
        completion()
    })
}
func showMsg(text:String) {
    let cellSize = Game.instance.cellSize
    let node = SKSpriteNode()
    let width = (text.count * 24 + 100).toFloat()
    let rect = CGRect(x: -width * 0.5, y: -cellSize, width: width, height: cellSize * 2)
    let bg = SKShapeNode(rect: rect, cornerRadius: 4)
    bg.fillColor = UIColor.black
    bg.alpha = 0.65
    node.addChild(bg)
    
    let border = SKShapeNode(rect: rect, cornerRadius: 4)
    border.lineWidth = 2
    node.addChild(border)
    
    let l = Label()
    l.fontSize = 24
    l.align = "center"
    l.fontColor = UIColor.white
    l.text = text
    l.position.y = 12
    node.addChild(l)
    
    node.zPosition = 1200
    let stage = Game.instance.curStage!
    stage._messageNode.removeFromParent()
    stage._messageNode = node
//    node.isUserInteractionEnabled = true
    stage.addChild(node)
    setTimeout(delay: 3, completion: {
        node.removeFromParent()
        stage._messageNode = SKSpriteNode()
    })
}
func createBackground(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat, height: CGFloat, cornerRadius: CGFloat = Game.CORNER_RADIUS) -> SKShapeNode {
//    let b = CGRect(x: -width * 0.5, y: -height * 0.5, width: width, height: height)
//    let bg = SKShapeNode(rect: b, cornerRadius: cornerRadius)
    let bg = SKShapeNode(rectOf: CGSize(width: width, height: height), cornerRadius: cornerRadius)
    bg.fillColor = UIColor.black
    bg.strokeColor = Game.UNSELECTED_STROKE_COLOR
    bg.lineWidth = Game.UNSELECTED_STROKE_WIDTH
    bg.position.x = width * 0.5
    bg.position.y = -height * 0.5
//    bg.zPosition = zPos
    return bg
}
func createBorder(width: CGFloat, height: CGFloat, color:UIColor = UIColor.white) -> SKSpriteNode {
    let node = SKSpriteNode()
    node.anchorPoint = CGPoint(x: 0, y: 1)
    node.size = CGSize(width: width, height: height)
    node.color = color
    return node
}
