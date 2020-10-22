//
//  ViewController.swift
//  caculator
//
//  Created by njuios on 2020/10/20.
//
// type 0
// -->
import UIKit
class acculatorModel
{
    var ans:Int
    var currentnum:Double
    var prenum:Double
    var pprenum:Double
    var Operator:String
    var preop:String
    var ppreop:String
    var type:Int
    var showS:String
    var m:Double
    init (initans:Int)
    {
        self.ans=initans
        self.currentnum=0
        self.Operator=""
        self.ppreop=""
        self.pprenum=0
        self.type=0
        self.preop=""
        self.prenum=0
        self.m=1
        self.showS="0"
    }
    private func check(num:Double)->String
    {
        if round(num)==num
        {
            return String(Int(num))
        }
        return String(num)
    }
    
    private func getans()-> Double
    {
        if preop==""
        {
            return currentnum
        }
        if ppreop==""
        {
            switch preop {
            case "+":
                return currentnum+prenum
            case "-":
                return prenum-currentnum
            case "x":
                return currentnum*prenum
            default:
                 if currentnum != 0
                 {return prenum/currentnum}
            }
        }
        var tmpresult:Double = 0.0
        if preop=="x"
        {
             tmpresult=prenum * currentnum
        }
        else
        {
            tmpresult=prenum / currentnum
        }
        if ppreop=="+"
        {
            return pprenum+tmpresult
        }
        else
        {
            return pprenum-tmpresult
        }
        
    }
    private func getupdate()
    {
        if preop==""
        {
            prenum=currentnum
            currentnum=0
            preop=Operator
            Operator=""
            return
        }
        if ppreop==""
        {
            if (preop=="+" || preop=="-") && (Operator=="x" || Operator=="/")
            {
                pprenum=prenum
                prenum=currentnum
                ppreop=preop
                preop=Operator
                Operator=""
                return
            }
            switch preop
            {
            case "x":
                prenum=currentnum*prenum
            case "/":
                if currentnum != 0
                {prenum=prenum/currentnum}
            case "+":
                prenum=prenum+currentnum
            default:
                prenum=prenum-currentnum
            }
            currentnum=0
            preop=Operator
            Operator=""
            return
        }
        var tmpresult:Double = 0.0
        if preop=="x"
        {
             tmpresult=prenum * currentnum
        }
        else
        {
            tmpresult=prenum / currentnum
        }
        switch Operator {
        case "+","-":
            if ppreop=="+"
            {
                prenum=pprenum+tmpresult
            }
            if ppreop=="-"
            {
                prenum=pprenum-tmpresult
            }
            currentnum=0
            preop=Operator
            ppreop=""
            Operator=""
        default:
            prenum=tmpresult
            preop=Operator
            Operator=""
            currentnum=0
        }
    }
    
    private func updates(s:String)-> String
    {
        if preop == ""
        {
            return showS
        }
        if ppreop == ""
        {
            if (preop=="+" || preop=="-") && (Operator=="x" || Operator=="/")
            {
                return showS
            }
            switch preop {
            case "x":
                return check(num:currentnum*prenum)
            case "/":
                if currentnum==0
                { return "divide 0!"}
                return check(num:prenum/currentnum)
            case "+":
                return check(num:currentnum+prenum)
            default:
                return check(num:prenum-currentnum)
            }
        }
        var tmpresult:Double = 0.0
        if preop=="x"
        {
             tmpresult=prenum * currentnum
        }
        else
        {
            if currentnum==0
            { return "divide 0!"}
            tmpresult=prenum / currentnum
        }
        
        switch s {
        case "+","-":
            if ppreop=="+"
            {
                return check(num:pprenum+tmpresult)
            }
            if ppreop=="-"
            {
                return check(num:pprenum-tmpresult)
            }
        default:
            return check(num:tmpresult)
        }
        return "error"
    }
    
    private func percentS(s:String)->String
    {
        if Int(s)==0
        {
            return "0"
        }
        var tmps=s
        if tmps.contains("-")
        {
            tmps.remove(at: tmps.startIndex)
        }
        var length=tmps.count
        if tmps.contains(".")
        {
            print(1)
            let arrays=tmps.components(separatedBy: ".")
            var tmpl=arrays[0].count
            tmps=arrays[0]
            if tmpl==2
            {
                tmps="0"+tmps
                tmpl=tmpl+1
            }
            if tmpl==1
            {
                tmps="00"+tmps
                tmpl=tmpl+2
            }
            
            let substr1 = tmps.prefix(tmpl-2)+"."
            let substr2 = tmps.suffix(2)
            var anss=String(substr1 + substr2+arrays[1])
            while anss.hasSuffix("0")
            {
                //print(anss)
                anss.remove(at:anss.index(before: anss.endIndex))
            }
            if anss.hasSuffix(".")
            {
                anss.remove(at:anss.index(before: anss.endIndex))
            }
            return anss
        }
        else
        {
            if length==2
            {
                tmps="0"+tmps
                length=length+1
            }
            if length==1
            {
                tmps="00"+tmps
                length=length+2
            }
            
            let substr1 = tmps.prefix(length-2)+"."
            let substr2 = tmps.suffix(2)
            var anss=String(substr1 + substr2)
            while anss.hasSuffix("0")
            {
                print(anss)
                anss.remove(at:anss.index(before: anss.endIndex))
            }
            if anss.hasSuffix(".")
            {
                anss.remove(at:anss.index(before: anss.endIndex))
            }
            return anss
        }
        
        //return "error"
    }
    
    public func numberclicked(num:Int) -> String
    {
        //print(num," ",type)
        if type <= 1
        {
            if type==1
            {
                if currentnum==0
                {
                    if num != 0
                    {showS=String(num)}
                }
                else
                {
                    showS=showS+String(num)
                }
            }
            else
            {
                if showS.contains("-")
                {
                    showS="-"+String(num)
                }
                else
                {
                    showS=String(num)
                }
                
            }
            type = 1
            if showS.contains("-")
            {
            self.currentnum = self.currentnum * 10 - Double(num)
            }
            else
            {
                self.currentnum = self.currentnum * 10 + Double(num)
            }
        }
      
        if type == 2
        {
            m=m*0.1
            showS=showS+String(num)
            self.currentnum=self.currentnum+m*Double(num)
        }
        if  type == 3
        {
            getupdate()
            currentnum=Double(num)
            showS=String(num)
            type = 1
        }
        return showS
        
    }
    
    public func operatorclicked(op:String) -> String
    {
        //print(op)
        switch op {
        case ".":
            if self.type == 1
            {
                showS=showS+"."
                self.type = 2
            }
            if type==4
            {
                currentnum=0
                showS="0."
                type = 2
            }
            if type == 3
            {
                getupdate()
                currentnum=0
                showS="0."
                type = 2
            }
        case "AC":
            self.currentnum=0
            self.Operator=""
            self.type=0
            self.preop=""
            self.ppreop=""
            self.pprenum=0
            self.prenum=0
            self.m=1
            self.showS="0"
        case "%":
                if type<=2 || type==4
                {
                    self.currentnum=currentnum/100
                    if round(self.currentnum) != self.currentnum
                    {
                        type=2
                        m=m*0.01
                    }
                    showS=percentS(s: showS)
                }
            
        case "+/-":
            if type<=2 || type==4
            {
                self.currentnum=currentnum*(-1)
                if showS.contains("-")
                {
                    showS.remove(at: showS.startIndex)
                }
                else
                {
                    showS="-"+showS
                }
            }
        case "x","/","+","-":
            m=1
            type = 3
            Operator=op
            showS=updates(s:op)
            
        case "=":
            type=4
            currentnum=getans()
            prenum=0
            pprenum=0
            preop=""
            ppreop=""
            Operator=""
            m=1
            showS=check(num:currentnum)
            
            print("=")
        case "C":
            if  type<=2 || type == 4
            {
                currentnum=0
                showS="0"
            }
            if type == 3
            {
                showS="0"
            }
            
        default:
            print("")
        }
        print(pprenum," ",ppreop," ",prenum," ",preop," ",currentnum," ",Operator )
        return showS
    }
}

class ViewController: UIViewController {
    
    let a=acculatorModel(initans:0)
    var flag = 0
    @IBOutlet weak var viewans: UILabel!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var multiple: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var equal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    private func update()
    {
        if plus.currentTitleColor !=  equal.currentTitleColor
        {
            plus.setTitleColor(equal.currentTitleColor, for:.normal)
            plus.backgroundColor=equal.backgroundColor
        }
        if minus.currentTitleColor !=  equal.currentTitleColor
        {
            minus.setTitleColor(equal.currentTitleColor, for:.normal)
            minus.backgroundColor=equal.backgroundColor
        }
        if multiple.currentTitleColor !=  equal.currentTitleColor
        {
            multiple.setTitleColor(equal.currentTitleColor, for:.normal)
            multiple.backgroundColor=equal.backgroundColor
        }
        if divide.currentTitleColor !=  equal.currentTitleColor
        {
            divide.setTitleColor(equal.currentTitleColor, for:.normal)
            divide.backgroundColor=equal.backgroundColor
        }
    }
    @IBAction func clickoperator(_ sender: UIButton)
    {
        switch sender.currentTitle {
        case "+","-","x","/":
            update()
            sender.setTitleColor(equal.backgroundColor, for: .normal)
            sender.backgroundColor=equal.currentTitleColor
        default:
            update()
        }
        switch sender.currentTitle
        {
        case "AC","C","+/-","%","/","x","-","+","=",".":
            let show = a.operatorclicked(op: sender.currentTitle!)
            viewans.text=show
            if sender.currentTitle=="C"
            {
                ACButton.setTitle("AC", for: .normal)
            }
        case "1","2","3","4","5","6","7","8","9","0":
            if ACButton.currentTitle=="AC"
            {
                ACButton.setTitle("C", for: .normal)
            }
            let show = a.numberclicked(num:Int(sender.currentTitle!)!)
            viewans.text=show
        default:
            print("")
            
        }
        
    }
    
    
    

}

