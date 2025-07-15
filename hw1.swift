

class Car {
    let brand: String
    let power: Int
    let model: String
    
    init(brand: String, power: Int, model: String) {
        self.brand = brand
        self.power = power
        self.model = model
    }
    
    func displayInfo() {
        print("Brand: \(brand), Model: \(model), Power: \(power)", terminator: ", ")
    }
}


class BMW: Car {
    let fuelConsumption: Int
    
    init(power: Int, model: String, fuelConsumption: Int) {
        self.fuelConsumption = fuelConsumption
        super.init(brand: "BMW", power: power, model: model)
    }
    
    open override func displayInfo() {
        super.displayInfo()
        print("FuelConsumption:", fuelConsumption)
    }
}


class Tesla: Car {
    let energyConsumption: Int
    
    init(power: Int, model: String, energyConsumption: Int) {
        self.energyConsumption = energyConsumption
        super.init(brand: "Tesla", power: power, model: model)
    }
    
    open override func displayInfo() {
        super.displayInfo()
        print("EnergyConsumption:", energyConsumption)
    }
}


class Wolkswagen: Car {
    let fuel_to_energy: Int
    
    init(power: Int, model: String, fuel_to_energy: Int) {
        self.fuel_to_energy = fuel_to_energy
        super.init(brand: "Wolkswagen", power: power, model: model)
    }
    
    open override func displayInfo() {
        super.displayInfo()
        print("Fuel to energy:", fuel_to_energy)
    }
}


func createCars(count: Int) -> [Car] {
    guard count > 0 && count % 2 == 0  else {
        print("Нужно четное число автомобилей")
        return []
    }
    
    var cars: [Car] = []
    let brands = ["BMW", "Tesla", "Wolkswagen"]
    
    for _ in 0..<count {
        let randomBrand = brands.randomElement()
        let model = "Model \(Int.random(in: 1...10))"
        let power = Int.random(in: 150...300)
        
        switch randomBrand {
        case "BMW":
            cars.append(BMW(power: power, model: model, fuelConsumption: Int.random(in: 8...15)))
        case "Tesla":
            cars.append(Tesla(power: power, model: model, energyConsumption: Int.random(in: 100...200)))
        case "Wolkswagen":
            cars.append(Wolkswagen(power: power, model: model, fuel_to_energy: Int.random(in: 1...3)))
        default:
            break
        }
    }
    
    return cars
}


func race(cars: [Car], count: Int) {
    var countCur = count
    countCur += 1
    
    print("Race number \(countCur):")
    for c in cars {
        print(c.displayInfo(), terminator: "; ")
    }
    
    var winners: [Car] = []
    
    for c in stride(from: 0, to: cars.count - 1, by: 2) {
        let car1 = cars[c]
        let car2 = cars[c + 1]
        
        let winner = car1.power > car2.power ? car1 : car2
        winners.append(winner)
    }
    if cars.count % 2 == 1 {
        winners.append(cars[cars.count - 1])
    }
    
    if (winners.count > 1) {
        race(cars: winners, count: countCur)
    }
    else {
        print("Winner:")
        winners[0].displayInfo()
    }
}


race(cars: createCars(count: 6), count: 0)

