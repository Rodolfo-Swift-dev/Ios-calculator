//  HomeViewController.swift
//  Created by rodoolfo gonzalez on 14-02-23.
import UIKit

// final para tener controlado nuestro scope, evitando que nuestra clase se extienda. asi controlamos la funcionalidad de cada componente.
final class HomeViewController: UIViewController {
    
    //MARK: - Outlet Label
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: - Outlet Number Buttons
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //MARK: - Outlet Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorDiv: UIButton!
    @IBOutlet weak var operatorMultipli: UIButton!
    @IBOutlet weak var operatorSubstract: UIButton!
    @IBOutlet weak var operatorAdd: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorBitcoin: UIButton!
    
    //MARK: - Variables
    //private ya que el scope de estas variables va a ser solo esta clasi y asi controlamos funcionalidad
    
    private var total : Double = 0 // valor del total
    private var temp : Double = 0 // valor temporal que se muestra en pantalla
    private var operating = false // indica si se ha seleccionado un operador (+,-,/,x,%)
    private var decimal = false // nos  indica si presionamos el operador decimal, lo que la calculadora comienza a tratar con numeros decimales
    private var activeDecimal = false
    private var operation : OperationType = .none // operacion actual
    private var indexDecimal = 0
    
    
    //MARK: - Constantes
    
    let networking = NetworkingProvider()
    private let kDecimalSeparator = Locale.current.decimalSeparator! // calcular simbolo decimal entre "." o "," segun nuestro idioma o pais.
    private let kNumMaxDigits = 9 // maxima cantidad de digitos
    private let kMaxNum : Double = 999999999 // numer mas alto permitido
    private let kMinNum = 0.00000001 // numero mas bajo permitido
    
    // define tipos de operaciones que soporta nuestra calculadora (+,_,/,x,% o nada) o tambien .none en el caso que no se haya seleccionado una operacion o que una operacion este resuelta
    private enum OperationType{
        case none, add, substract, multiplication, div
    }
    
    
    //MARK: - Formateo de valores auxiliare
    
    private let transformFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        
        return formatter
    }()
    
    
    // encargado de formatear valores que vamos atrabajar en nuestra App
    private let auxFormatter : NumberFormatter = {
        //creamos formateador de numero
        let formatter = NumberFormatter()
        //creamos un objeto local para que sea igual que el dispositivo que se esta ejecutando la App.
        let locale = Locale.current
        //configuramos el separador de grupo del formateador(ejemplo 1"."500), que sera un espacio vacio.
        formatter.groupingSeparator = ""
        //configuramos el separador decimal del formateador, que se igualara al local del dispositivo donde se ejecuta la App.
        formatter.decimalSeparator = locale.decimalSeparator
        //configuramos el estilo que puede ser currency, decimal o porcentaje
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9
        return formatter
    }()
    
    
    //MARK: - Formateo de valores por pantalla por defecto
    // encargado de mostrar visualmente y como queremos mostrar numero por pantalla
    private let printFormatterCurrency : NumberFormatter = {
        
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.maximumIntegerDigits = 9
        // configuramos el formateador su minima cantidad de digitos despues de la coma(decimal), es decir puede que no tengamos decimales.
        formatter.minimumFractionDigits = 0
        // configuramos el formateador su maxima cantidad de digitos despues de la coma(decimal)
        formatter.maximumFractionDigits = 4
        
        formatter.numberStyle = .currency
        return formatter
        
    }()
    private let printFormatter : NumberFormatter = {
        //creamos formateador de numero
        let formatter = NumberFormatter()
        //creamos un objeto local para que sea igual que el dispositivo que se esta ejecutando la App.
        let locale = Locale.current
        //configuramos el separador de grupo del formateador(ejemplo 1"."500), que se igualara al local del dispositivo donde se ejecuta la App.
        formatter.groupingSeparator = locale.groupingSeparator
        
        //configuramos el separador decimal del formateador, que se igualara al local del dispositivo donde se ejecuta la App.
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        // configuramos el formateador su maxima cantidad de digitos
        formatter.maximumIntegerDigits = 9
        // configuramos el formateador su minima cantidad de digitos despues de la coma(decimal), es decir puede que no tengamos decimales.
        formatter.minimumFractionDigits = 0
        // configuramos el formateador su maxima cantidad de digitos despues de la coma(decimal)
        formatter.maximumFractionDigits = 8
        return formatter
        
    }()
    
    //implementacion de como queremos instanciar VC
    //como queremos que se instancie un VC
    //MARK: - Initialization
    init() {
        // super = a llamar a la superclase de nuestro VC, y los parametros al estar comno nulos, por defecto esta clase se inicializa con el xib file asociado que hemos creado.
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - UI
        //redondeo de botones
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        operatorAC.round()
        operatorDiv.round()
        operatorMultipli.round()
        operatorSubstract.round()
        operatorAdd.round()
        operatorResult.round()
        operatorBitcoin.round()
        // asignamos el separador decimal correspondiente segun el Locale
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        result()
        
    }
    
    //MARK: - Action operators Buttons
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operatorDivAction(_ sender: UIButton) {
        if !operating{
            result()
        }
        operating = true
        operation = .div
        
        sender.shine()
    }
    @IBAction func operatorMultipliAction(_ sender: UIButton) {
        if !operating{
            result()
        }
        operating = true
        operation = .multiplication
        
        sender.shine()
    }
    @IBAction func operatorSubstractAction(_ sender: UIButton) {
        if !operating{
            result()
        }
        operating = true
        operation = .substract
        sender.shine()
    }
    @IBAction func operatorAddAction(_ sender: UIButton) {
        if !operating{
            result()
        }
        operating = true
        operation = .add
        print(temp)
        print(total)
        
        
        sender.shine()
    }
    @IBAction func operatorResultAction(_ sender: UIButton) {
        result()
        temp = 0
        decimal = false
        operating = false
        operation = .none
        activeDecimal = false
        sender.shine()
        
    }
    @IBAction func operatorBitcoinAction(_ sender: UIButton) {
        var currentTemp = ""
        var numberTemp = 0.0
        
        NetworkingProvider.shared.getCoin { coinResponse in
            if let result = coinResponse.rate{
                numberTemp = result
                currentTemp = self.transformFormatter.string(from: NSNumber(value: result))!
                if let tempFormatter = Double(currentTemp){
                    numberTemp = tempFormatter
                }
                print(currentTemp)
                self.resultLabel.text = self.printFormatterCurrency.string(from: NSNumber(value: numberTemp))
                
            }
            
        } failure: { error in
            print(error?.localizedDescription)
        }
       
        activeDecimal = false
        sender.shine()
    }
    
    //MARK: - Action operators Buttons
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        var currentTemp = transformFormatter.string(from: NSNumber(value: temp))!
        if resultLabel.text!.contains(kDecimalSeparator){
            //detener ejecucion funcion actual
            return
        }
        
        resultLabel.text! += kDecimalSeparator
        decimal = true
        activeDecimal = true
        sender.shine()
    }
    
    @IBAction func numbersAction(_ sender: UIButton) {
        
        
        var transformCurrentTemp = ""
        var currentTemp = ""
        if activeDecimal{
            indexDecimal += 1
        }
        operatorAC.setTitle("C", for: .normal)
        
        if resultLabel.text?.last == "0", activeDecimal, sender.tag != 0{
            
            var newText = resultLabel.text!.replacingOccurrences(of: ",", with: ".")
            newText += sender.tag.description
            if let convert = Double(newText){
                temp = convert
                print("convert\(convert)")
            }
     
            print("temp\(temp)")
           
            
        }else{
            transformCurrentTemp = transformFormatter.string(from: NSNumber(value: temp))!
            currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        }
       
// verificacion de cantidad de digitos, si es decimal, o esta operando
        if  currentTemp.count >= kNumMaxDigits{
            //detener ejecucion funcion actual
            return
        }
        if decimal{
            currentTemp += "."
            transformCurrentTemp += "."
            decimal = false
        }
        if operating{
            total = total == 0 ? temp : total
            transformCurrentTemp = ""
            resultLabel.text = ""
            operating = false
        }
        
//Añadimos el numero presionado
        currentTemp += String(sender.tag)
        transformCurrentTemp += String(sender.tag)
        /* if sender == 0{
        temp += sender.tag
         }*/
        
        if sender.tag == 0, activeDecimal{
            
            let decimalFormatter : NumberFormatter = {
                let formatter = NumberFormatter()
                let locale = Locale.current
                formatter.groupingSeparator = ""
                formatter.decimalSeparator = "."
                formatter.numberStyle = .decimal
                formatter.maximumIntegerDigits = 9
                formatter.minimumFractionDigits = indexDecimal
                formatter.maximumFractionDigits = 8
                
                return formatter
            }()
            currentTemp = decimalFormatter.string(from: NSNumber(value: temp))!
           
                var resulText = resultLabel.text!
                resulText += "0"
            
                self.resultLabel.text! = resulText
                
                print("temp \(temp)")
                print("resultlabel \(resultLabel.text!)")
                
            
            
        }else if sender.tag != 0, activeDecimal, resultLabel.text!.last == "0"{
            let decimalFormatter : NumberFormatter = {
                let formatter = NumberFormatter()
                let locale = Locale.current
                formatter.groupingSeparator = ""
                formatter.decimalSeparator = "."
                formatter.numberStyle = .decimal
                formatter.maximumIntegerDigits = 9
                formatter.minimumFractionDigits = indexDecimal
                formatter.maximumFractionDigits = 8
                
                return formatter
            }()
            currentTemp = decimalFormatter.string(from: NSNumber(value: temp))!
           
                var resulText = resultLabel.text!
            resulText += "\(sender.tag)"
            
                self.resultLabel.text! = resulText
                
                print("temp \(temp)")
                print("resultlabel \(resultLabel.text!)")
        }else{
            if let result = Double( transformCurrentTemp){
                temp = result
                print("temp \(temp)")
            }
            self.resultLabel.text! = self.printFormatter.string(from: NSNumber(value: self.temp))!
            print("resultlabel \(resultLabel.text!)")
            
        }
       
     
      
        
        sender.shine()
        
    }
    
    // limpia los valores
    private func clear(){
        operation = .none
        
        if operatorAC.titleLabel?.text == "C"{
            total = 0
            temp = 0
            resultLabel.text = "0"
            
        }else{
            total = 0
            temp = 0
            resultLabel.text = "0"
            operation = .none
            operating = false
            decimal = false
            activeDecimal = false
            result()
        }
        activeDecimal = false
        indexDecimal += 0
        operatorAC.setTitle("AC", for: .normal)
        
        
    }
    //obtiene resultado total
    private func result(){
        activeDecimal = false
        indexDecimal += 0
        switch operation {
            //los "break" son para detener la ejecucion del switch cuando se du uno de los casos
        case .none:
            //en el caso de que sea none no se ejecuta ningun codigo
            break
        case .add:
            total +=  temp
            break
        case .substract:
            total -=  temp
            break
        case .multiplication:
            total *= temp
            break
        case .div:
            total /= temp
            break
            
        }
        //formateo en pantalla
        if (total <= kMaxNum && total >= kMinNum){
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
    }
}
