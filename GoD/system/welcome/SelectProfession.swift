//
//  SelectProfession.swift
//  GoD
//
//  Created by kai chen on 2018/12/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelecProfession:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        for b in _buttons {
            if b.contains(touchPoint!) {
                _index = b.index
                _selectedRole = _infos[_index]
                createProComponent()
                b.selected = true
            } else {
                b.selected = false
            }
        }
        if _nextButton.contains(touchPoint!) {
            nextAction()
            return
        }
        if _prevButton.contains(touchPoint!) {
            prevAction()
            return
        }
        
        if _closeButton.contains(touchPoint!) {
            closeAction()
            return
        }
        
    }
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "抉择：选择职业"
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _nextButton.text = "下一步"
        
        _infos = [
            ["游侠", "成为一名游侠，你将会获得6点属性成长、可同时使用2个技能、可配置2个随从跟随战斗，并且可以装备武器、饰品、盾牌、魔印、灵魂石和左右法戒。", 6, true, true, true, 2, 2, [BreakDefence()]],
            ["傀儡师", "成为一名儡师，你将会获得4点属性成长、可同时使用3个技能、可配置3个随从跟随战斗，并且可以装备武器、饰品、灵魂石和左右法戒。", 4, true, false, false, 3, 3, [Petrify()]],
            ["使徒", "成为一名使徒，你将会获得5点属性成长、可同时使用2个技能、可配置3个随从跟随战斗，并且可以装备盾牌、饰品、魔印、灵魂石和左右法戒。", 5, false, true, true, 3, 2, [Heal()]],
            ["巫师", "成为一名巫师，你将会获得5点属性成长、可同时使用3个技能、可配置2个随从跟随战斗，并且可以装备武器、饰品、魔印、灵魂石和左右法戒。", 5, true, false, true, 2, 3, [Predict()]],
            ["冒险者", "成为一名冒险者，你将会获得5点属性成长、可同时使用3个技能、可配置3个随从跟随战斗，并且可以装备武器、盾牌，饰品、灵魂石和左右法戒。", 5, true, true, false, 3, 3, [LowlevelFlame()]]
//            ["随机", "获得随机模型，你将会获得?点属性成长、可同时使用?个技能、可配置?个随从跟随战斗，并且可以装备?,?,?,饰品、灵魂石和左右法戒。", [4,4,4,5,5,5,6,6,6,7,7].one(), [true, true, true, false, false, false].one(), [true, true, true, false, false, false].one(), [true, true, true, false, false, false].one(), [1,1,1,2,2,2,3,3,3].one(), [1,1,1,2,2,2,3,3].one(), [Loot().getRandomSacredSpell()]],
//            ["", "成为一个武道家，你将会获得6点属性成长、可同时使用2个技能、可配置2个随从跟随战斗，并且可以装备饰品、灵魂石和左右法戒。", 6, false, false, false, 2, 2, []]
        ]
        createProComponent()
        createButtons()
    }
    func createProComponent() {
        _component?.removeFromParent()
        let pc = ProfessionComponent()
        pc.create(profession: _infos[_index][0] as! String,
                  desc: _infos[_index][1] as! String,
                  growthPoint: _infos[_index][2] as! Int,
                  hasWeapon: _infos[_index][3] as! Bool,
                  hasShield: _infos[_index][4] as! Bool,
                  hasMark: _infos[_index][5] as! Bool,
                  battleSeat: _infos[_index][6] as! Int,
                  spellCount: _infos[_index][7] as! Int,
                  spells: _infos[_index][8] as! Array<Spell>
        )
        pc.xAxis = -cellSize * 3.75
        pc.yAxis = cellSize * 3.25
        pc.zPosition = self.zPosition + 3
        addChild(pc)
        _component = pc
    }
    override func createPanelbackground() {
        super.createPanelbackground()
    }
    private func createButtons() {
        for i in 0..._infos.count - 1 {
            let pb = ProButton()
            pb.text = _infos[i][0] as! String
            pb.yAxis = -cellSize * 2.45
            pb.xAxis = -cellSize * 3.75 + pb.width * i.toFloat()
            pb.zPosition = self.zPosition + 3
            pb.index = i
            addChild(pb)
            _buttons.append(pb)
        }
    }
    override func close() {
        
    }
    private var _infos = Array<Array<Any>>()
    private var _index = 0
    private var _component:ProfessionComponent?
    private var _buttons = Array<ProButton>()
    var _selectedRole:Array<Any>!
    
}
class ProButton: Button {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var index = 0
}
class ProfessionComponent:SelectableComponent {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _spellInfoPanel?.removeFromParent()
        for c in _components {
            if c.contains(touchPoint!) {
                showSpellInfo(c)
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _background = createBackground(width: cellSize * 7.5, height: cellSize * 5.5)
        _background.strokeColor = Game.UNSELECTED_STROKE_COLOR
        addChild(_background)
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func showSpellInfo(_ si:SpellIcon) {
        let spellInfo = SpellInfo()
        spellInfo.create(spell: si.spell!)
        spellInfo.zPosition = MyStage.UI_TOPEST_Z
        spellInfo.position.x = si.position.x
        spellInfo.position.y = si.position.y + spellInfo._displayHeight + cellSize * 0.25
        addChild(spellInfo)
        _spellInfoPanel = spellInfo
    }
    private var _spellInfoPanel:SpellInfo?
    
    func create(profession: String,
                desc: String,
                growthPoint: Int,
                hasWeapon: Bool,
                hasShield: Bool,
                hasMark: Bool,
                battleSeat: Int,
                spellCount: Int,
                spells: Array<Spell>) {
        
        let startX = cellSize * 0.25
        let startY = -cellSize * 0.25
        let gap = cellSize * 0.25
        
        let name = Label()
        name.position.x = startX
        name.position.y = startY
        name.fontSize = 30
        name.text = profession
        addChild(name)
        
        let des = MultipleLabel()
        des._lineCharNumber = 20
        des._fontSize = 24
        des.text = desc
        des.position.x = startX
        des.position.y = name.position.y - name.fontSize - gap
        addChild(des)
        
        let label = Label()
        label.position.x = startX
        label.position.y = -cellSize * 3.25
        label.fontSize = 28
        label.text = "天赋技能"
        addChild(label)
        var i:CGFloat = 0
        for u in spells {
            let si = SpellIcon()
            si.iconLabel = u._name
            si.spell = u
            si.xAxis = startX + i * (cellSize + gap)
            si.yAxis = label.position.y - cellSize * 0.75
            addChild(si)
            _components.append(si)
            i += 1
        }
        
    }
    private var _components = Array<SpellIcon>()
}
