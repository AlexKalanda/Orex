//
//  CarModel.swift
//  OREX
//
//  Created by admin on 12/10/2024.
//

import Foundation
import FirebaseFirestore

class CarModel: Identifiable {
    var id: String
    var type: CarType
    var title: String
    var image: String
    var stateNumber: String
    var equipment: [Equipment]
    var description: String
    var free: Bool
    var dates: [Date]
    
    init(id: String = UUID().uuidString, type: CarType, title: String, image: String, stateNumber: String, equipment: [Equipment], description: String, free: Bool, dates: [Date]) {
        self.id = id
        self.type = type
        self.title = title
        self.image = image
        self.stateNumber = stateNumber
        self.equipment = equipment
        self.description = description
        self.free = free
        self.dates = dates
    }
    
    
    // MARK: - инициализатор для получения техники из базы данных
    init?(data: [String : Any]) {
        guard let id = data["id"] as? String,
              let typeRawValue = data["type"] as? String,
              let title = data["title"] as? String,
              let image = data["image"] as? String,
              let stateNumber = data["stateNumber"] as? String,
              let equipmentRawValue = data["equipment"] as? [String],
              let description = data["description"] as? String,
              let free = data["free"] as? Bool,
              let timestamp = data["dates"] as? [Timestamp] else { return nil }
        
        guard let type = CarType(rawValue: typeRawValue) else { return nil }
        let equipment = equipmentRawValue.compactMap { item in
            let equipment = Equipment(rawValue: item)
            return equipment
        }
        let dates = timestamp.map { item in
            let item = item.dateValue()
            return item
        }
        self.id = id
        self.type = type
        self.title = title
        self.image = image
        self.stateNumber = stateNumber
        self.equipment = equipment
        self.description = description
        self.free = free
        self.dates = dates
    }
    
    enum CarType: String {
        case buldozer = "Бульдозер"
        case backhoeLoader = "Экскаватор-погрузчик"
        case compressor = "Компрессор"
        case miniLoader = "Мини-погрузчик"
        case manipulator = "Манипулятор"
        case wheeledExcavator = "Колесный экскаватор"
        case gusenichnyExcavator = "Гусеничный экскаватор"
        case forklift = "Вилочный погрузчик"
        case telescopicLoader = "Телескопический погрузчик"
    }
    
    enum Equipment: String {
        case ladle = "Ковш"
        case hammer = "Гидромолот"
        case pitchfork = "Вилы"
        case brush = "Щетка"
        case miniHammer = "Молот"
        case concreteBreaker = "Бетонолом"
        case purging = "Продувка"
    }
    
    static var dataBase: [CarModel] = [.init(type: .buldozer,
                                             title: "Бульдозер Б-10",
                                             image: "b10",
                                             stateNumber: "HH1283 77",
                                             equipment: [],
                                             description: "Бульдозеры семейства Б-10 предназначены для разработки грунтов I-III категории без предварительного рыхления, грунтов IV категории с предварительным рыхлением, а также трещиноватых скальных пород и мерзлых грунтов, планировки площадок, отрывки котлованов, засыпки траншей, оврагов. Бульдозерная техника данного класса применяется также для расчистки дорог от снега.",
                                             free: true,
                                             dates: []),
                                       .init(type: .buldozer,
                                             title: "Бульдозер Б-10",
                                             image: "b10",
                                             stateNumber: "HH3261 77",
                                             equipment: [],
                                             description: "Бульдозеры семейства Б-10 предназначены для разработки грунтов I-III категории без предварительного рыхления, грунтов IV категории с предварительным рыхлением, а также трещиноватых скальных пород и мерзлых грунтов, планировки площадок, отрывки котлованов, засыпки траншей, оврагов. Бульдозерная техника данного класса применяется также для расчистки дорог от снега.",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик Сukurova",
                                             image: "cukurov1",
                                             stateNumber: "HH1543 77",
                                             equipment: [.ladle],
                                             description: "Эксплуатационная мощность - 74,6 кВт.Модель двигателя - 1104C 44T.  Эксплуатационная масса - 8700 кг.Тип / Емкость погрузочного ковша - 4 в 1 / 1,1 м3.Ширина ковша - 2280 мм.Объем экскаваторного ковша - 0,25 м3.Стрела (тип)    телескопическая обратная лопата.Транспортная длина - 6220 мм.Высота в транспортном положении - 3760 мм.Максимальная ширина - 2280 мм. Глубина копания - 5800 мм. Высота выгрузки - 3850 мм",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик Сukurova",
                                             image: "cukurova2",
                                             stateNumber: "ВВ3243 77",
                                             equipment: [.ladle,.hammer],
                                             description: "Эксплуатационная мощность - 74,6 кВт.Модель двигателя - 1104C 44T.  Эксплуатационная масса - 8700 кг.Тип / Емкость погрузочного ковша - 4 в 1 / 1,1 м3.Ширина ковша - 2280 мм.Объем экскаваторного ковша - 0,25 м3.Стрела (тип)    телескопическая обратная лопата.Транспортная длина - 6220 мм.Высота в транспортном положении - 3760 мм.Максимальная ширина - 2280 мм. Глубина копания - 5800 мм. Высота выгрузки - 3850 мм",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик Сukurova",
                                             image: "cukurova3",
                                             stateNumber: "ВВ4413 77",
                                             equipment: [.ladle,.hammer,.pitchfork],
                                             description: "Эксплуатационная мощность - 74,6 кВт.Модель двигателя - 1104C 44T.  Эксплуатационная масса - 8700 кг.Тип / Емкость погрузочного ковша - 4 в 1 / 1,1 м3.Ширина ковша - 2280 мм.Объем экскаваторного ковша - 0,25 м3.Стрела (тип)    телескопическая обратная лопата.Транспортная длина - 6220 мм.Высота в транспортном положении - 3760 мм.Максимальная ширина - 2280 мм. Глубина копания - 5800 мм. Высота выгрузки - 3850 мм",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик JCB",
                                             image: "jcb1",
                                             stateNumber: "ВВ4743 77",
                                             equipment: [.ladle],
                                             description: "Эксплуатационная мощность - 63 кВт.Эксплуатационная масса - 7370 кг.Максимальный объем ковша для копания - 0,3 м3.Ширина ковша для копания - 60 см.Максимальная глубина копания - 4,24 м.Максимальный объем ковша для погрузки (фронтальный) - 1 м3.Ширина ковша для погрузки - 2,23 м.Максимальная скорость - 37 км/ч. Объем бака - 143 л.Максимальная грузоподъемность - 1850 кг.Максимальная высота подъема груза - 3,23 м",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик JCB",
                                             image: "jcb2",
                                             stateNumber: "ВВ4753 77",
                                             equipment: [.ladle],
                                             description: "Эксплуатационная мощность - 63 кВт.Эксплуатационная масса - 7370 кг.Максимальный объем ковша для копания - 0,3 м3.Ширина ковша для копания - 60 см.Максимальная глубина копания - 4,24 м.Максимальный объем ковша для погрузки (фронтальный) - 1 м3.Ширина ковша для погрузки - 2,23 м.Максимальная скорость - 37 км/ч. Объем бака - 143 л.Максимальная грузоподъемность - 1850 кг.Максимальная высота подъема груза - 3,23 м",
                                             free: true,
                                             dates: []),
                                       .init(type: .backhoeLoader,
                                             title: "Экскаватор погрузчик REDSTAR T28/28",
                                             image: "redstar1",
                                             stateNumber: "ВВ3753 77",
                                             equipment: [.ladle,.hammer],
                                             description: "Модель: REDSTAR T28/28.Масса, кг: 10400.Габариты (ДxШxВ), мм: 6420x2360x3100.Колесная база, мм: 2335.Ковш погрузчика, м³: 1,0.Грузоподъемность, кг: 2500.Высота выгрузки, мм: 3100.Ковш экскаватора, м³: 0,3.Двигатель: Yuchai.Модель двигателя: YC4A105Z-T20.Мощность, кВт: 75.Гидротрансформатор: YJ290.Рулевое устройство: BZZ5-250.: 16,9-28",
                                             free: true,
                                             dates: []),
                                       .init(type: .compressor,
                                             title: "Компрессор на базе газель Соболь",
                                             image: "compressor1",
                                             stateNumber: "Н645РР 77",
                                             equipment: [.miniHammer,.concreteBreaker,.purging],
                                             description: "Производительность: 8000 л/мин.Рабочее давление: 7 атм.На шасси: Да.Двигатель: Д-243 ММЗ",
                                             free: true,
                                             dates: []),
                                       .init(type: .compressor,
                                             title: "Компрессор на базе газель Соболь",
                                             image: "compressor1",
                                             stateNumber: "Н635РР 77",
                                             equipment: [.miniHammer,.concreteBreaker,.purging],
                                             description: "Производительность: 8000 л/мин.Рабочее давление: 7 атм.На шасси: Да.Двигатель: Д-243 ММЗ",
                                             free: true,
                                             dates: []),
                                       .init(type: .compressor,
                                             title: "Компрессор на базе газель Соболь",
                                             image: "compressor1",
                                             stateNumber: "Н625РР 77",
                                             equipment: [.miniHammer,.concreteBreaker,.purging],
                                             description: "Производительность: 8000 л/мин.Рабочее давление: 7 атм.На шасси: Да.Двигатель: Д-243 ММЗ",
                                             free: true,
                                             dates: []),
                                       .init(type: .compressor,
                                             title: "Компрессор на базе газель Соболь",
                                             image: "compressor1",
                                             stateNumber: "Н145РР 77",
                                             equipment: [.miniHammer,.concreteBreaker,.purging],
                                             description: "Производительность: 8000 л/мин.Рабочее давление: 7 атм.На шасси: Да.Двигатель: Д-243 ММЗ",
                                             free: true,
                                             dates: []),
                                       .init(type: .compressor,
                                             title: "Компрессор на базе газель Соболь",
                                             image: "compressor1",
                                             stateNumber: "Н649РР 77",
                                             equipment: [.miniHammer,.concreteBreaker,.purging],
                                             description: "Производительность: 8000 л/мин.Рабочее давление: 7 атм.На шасси: Да.Двигатель: Д-243 ММЗ",
                                             free: true,
                                             dates: []),
                                       .init(type: .miniLoader,
                                             title: "Мини-погрузчик BobCat",
                                             image: "bobcat1",
                                             stateNumber: "НВ6490 77",
                                             equipment: [.ladle,.hammer,.brush,.purging],
                                             description: "Габаритные размеры: длина – 2,588 метра (без ковша), 3,309 метра (со стандартным ковшом); ширина – 1,75 метра; высота с кабиной оператора – 1,938 метра. Ширина по шинам, 10-16,5 / 10-слойные – 1,676 метра. Общая масса – 2 855 кг (без учёта дополнительного оборудования). Максимальная грузоподъёмность по паспорту – 896 кг. Скорость передвижения – 12-18 км/час. Опрокидывающее усилие 1,8 тонн. Наибольшая высота подъёма ковша – 3,0 метра. Радиус поворота бортов со стандартным ковшом – 2,0 метра. Дорожный просвет – 191 мм. Рабочая высота – 3,862 метра. Задний угол свеса – 23 градуса. Колёсная база – 1030 мм. Ширина колеи, шины 10-16,5 / 10-слойные: 1,385 метра. Откат у земли – 25 градусов. Высота разгрузки со стандартным ковшом – 2,310 метра. Высота до пальца шарнира ковша – 3,002 метра. Радиус разгрузки на максимальной высоте – 753 мм. Угол разгрузки на максимальной высоте – 42 градуса. Откат при наибольшей высоте подъёма стрелы – 95 градусов. Ширина ковша 68 дюймов – 1,727 метра.",
                                             free: true,
                                             dates: []),
                                       .init(type: .manipulator,
                                             title: "Манипулятор JAC",
                                             image: "jac",
                                             stateNumber: "В590РО 77",
                                             equipment: [],
                                             description: "Габаритные размеры автомобиля, ДхШхВ (мм) - 10690х2550х3790. Полная масса (кг) - 19980.Снаряженная масса (кг) - 13650.Габаритные размеры бортовой платформы, ДхШхВ (мм) - 7200х2550х600.Основание бортовой платформы - Сварная рамная конструкция из открытых профилей. Состоит из продольных лонжеронов и поперечных балок, окантовочного и передней стенки профиля HOSSEN. Оцинкованные петли крепления груза в окантовочном профиле платформы (не уменьшают погрузочную ширину платформы), 6 шт. с каждой стороны.Пол - Влагостойкая фанера с противоскользящим покрытием толщиной.Борта платформы - Стальные оцинкованные или алюминиевые борта, откидывающиеся, количество секций – 2 шт. на сторону, высота 600 мм. Угол открывания бортов – 180О. Быстросъёмные стойки ломающегося типа по 1 шт. на сторону с алюминиевыми замками.Прочее оборудование    Пластиковые крылья, брызговики. Боковые влагозащитные габаритные огни. Боковая защита из алюминиевых профилей на откидных оцинкованных кронштейнах. Заднее защитное устройство. Ступень для подъёма на платформу.Характеристики крано-манипуляторной установки XCMG 250-4.Максимальный грузовой момент, тм - 25.Номинальная грузоподъёмность, кг - 10000.Номинальный рабочий радиус, м - 2,5.Г/п на максимальном вылете, кг - 1500.Максимальный вылет стрелы, м    13,5.Стрела - Гексагональная / 4 секции.Угол вращения колонны вокруг своей оси, град - 360° без ограничений.Угол подъема стрелы - 0° ~ 75°.Передние аутригеры - Размах 5,724 м.Задние аутригеры    Размах 3,7 м.Опционально - Установка бура, монтажной корзины",
                                             free: true,
                                             dates: []),
                                       .init(type: .manipulator,
                                             title: "Манипулятор КАМАЗ",
                                             image: "kmyKAMAZ",
                                             stateNumber: "В594РО 77",
                                             equipment: [],
                                             description: "Модель    43118-3027-50 / 43118-3090-50.Колесная формула    6x6.Двигатель    КАМАЗ 740.705-300 (Е-5).Мощность, л.с.    300.Коробка передач    154 / ZF9.Исполнение    Стальной борт.Длина, мм    6200.Ширина, мм    2550.Высота борта, мм    730.Боковые, задний борта    Откидные.Настил пола    Деревянный.Тип    Кран-манипулятор.Количество секций стрелы    6. Грузоподъемность, кг/м - 7500/2, 3500/4, 2000/7, 1200/10, 800/13, 600/15,9, 410/18.Максимальный рабочий радиус, м    18,9.Максимальная высота подъема, м    21,6",
                                             free: true,
                                             dates: []),
                                       .init(type: .manipulator,
                                             title: "Манипулятор КАМАЗ",
                                             image: "kmyKAMAZ2",
                                             stateNumber: "В594РО 77",
                                             equipment: [],
                                             description: "Модель    43118-3027-50 / 43118-3090-50.Колесная формула    6x6.Двигатель    КАМАЗ 740.705-300 (Е-5).Мощность, л.с.    300.Коробка передач    154 / ZF9.Исполнение    Стальной борт.Длина, мм    6200.Ширина, мм    2550.Высота борта, мм    730.Боковые, задний борта    Откидные.Настил пола    Деревянный.Тип    Кран-манипулятор.Количество секций стрелы    6. Грузоподъемность, кг/м - 7500/2, 3500/4, 2000/7, 1200/10, 800/13, 600/15,9, 410/18.Максимальный рабочий радиус, м    18,9.Максимальная высота подъема, м    21,6",
                                             free: true,
                                             dates: []),
                                       .init(type: .wheeledExcavator,
                                             title: "Колесный экскаватор XCMG 180",
                                             image: "xcmgK",
                                             stateNumber: "ВO5954 77",
                                             equipment: [.ladle,.hammer],
                                             description: "Эксплуатационная масса 17.6 т Мощность двигателя 141 л.с. Габариты (ДхШхВ) 8580х2490х3190 мм Объем стандартного ковша 0,89 м³ Тяговое усилие 117 кН Стрела 5100 мм Рукоять 2620 мм Модель двигателя Cummins QSB4,5 Максимальная глубина копания 5835 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .gusenichnyExcavator,
                                             title: "Гусеничный экскаватор XCMG 180",
                                             image: "xcmg1",
                                             stateNumber: "В05132 77",
                                             equipment: [.ladle,.hammer],
                                             description: "Эксплуатационная масса 18,1 т Мощность двигателя 126 л.с. Габариты (ДхШхВ) 8743х2490х3120 мм Объем стандартного ковша 0,91 м³ Стрела 5150 мм Рукоять 2635 мм Модель двигателя Cummins QSF3.8 Максимальная глубина копания 6000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .gusenichnyExcavator,
                                             title: "Гусеничный экскаватор XCMG 180",
                                             image: "xcmg1",
                                             stateNumber: "В01132 77",
                                             equipment: [.ladle,.hammer],
                                             description: "Эксплуатационная масса 18,1 т Мощность двигателя 126 л.с. Габариты (ДхШхВ) 8743х2490х3120 мм Объем стандартного ковша 0,91 м³ Стрела 5150 мм Рукоять 2635 мм Модель двигателя Cummins QSF3.8 Максимальная глубина копания 6000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .forklift,
                                             title: "Вилочный погрузчик 3 т.",
                                             image: "vil1",
                                             stateNumber: "В01132 77",
                                             equipment: [],
                                             description: "Длина-2744 мм.Ширина-1220 мм.Высота-2090 мм.Масса-4300 кг.Высота мачты в разложенном состоянии-4260мм.Грузоподъемность-3000 кг.Высота подъема груза-3000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .forklift,
                                             title: "Вилочный погрузчик 3 т.",
                                             image: "vil2",
                                             stateNumber: "В01122 77",
                                             equipment: [],
                                             description: "Длина-2744 мм.Ширина-1220 мм.Высота-2090 мм.Масса-4300 кг.Высота мачты в разложенном состоянии-4260мм.Грузоподъемность-3000 кг.Высота подъема груза-3000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .forklift,
                                             title: "Вилочный погрузчик 3 т.",
                                             image: "vil1",
                                             stateNumber: "В01123 77",
                                             equipment: [],
                                             description: "Длина-2744 мм.Ширина-1220 мм.Высота-2090 мм.Масса-4300 кг.Высота мачты в разложенном состоянии-4260мм.Грузоподъемность-3000 кг.Высота подъема груза-3000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .forklift,
                                             title: "Вилочный погрузчик 3 т.",
                                             image: "vil2",
                                             stateNumber: "В01124 77",
                                             equipment: [],
                                             description: "Длина-2744 мм.Ширина-1220 мм.Высота-2090 мм.Масса-4300 кг.Высота мачты в разложенном состоянии-4260мм.Грузоподъемность-3000 кг.Высота подъема груза-3000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .forklift,
                                             title: "Вилочный погрузчик 3 т.",
                                             image: "vil1",
                                             stateNumber: "В01125 77",
                                             equipment: [],
                                             description: "Длина-2744 мм.Ширина-1220 мм.Высота-2090 мм.Масса-4300 кг.Высота мачты в разложенном состоянии-4260мм.Грузоподъемность-3000 кг.Высота подъема груза-3000 мм.",
                                             free: true,
                                             dates: []),
                                       .init(type: .telescopicLoader,
                                             title: "Телескопический погрузчик Sany 1840",
                                             image: "STH",
                                             stateNumber: "В03165 77",
                                             equipment: [.ladle,.pitchfork],
                                             description: "Мощность двигателя - кВт 73.Высота транспортная - мм 2550.Длина транспортная - мм 7690.Ширина транспортная - мм 2428.Тип двигателя - Cummins QSF3.8.Радиус поворота (min) - мм 3870.Мощность - кВт / об. мин. - 73 / 2200.Максимальный крутящий момент - нМ / об. мин. - 420 / 1300.Грузоподъёмность - кг 4000.Грузоподъёмность на максимальной высоте с опущенными аутригерами - кг 2500.Грузоподъёмность на максимальном вылете стрелы с опущенными аутригерами - кг 550.Максимальная высота подъёма - м 17,55.Максимальный горизонтальный вылет стрелы - м 13.",
                                             free: true,
                                             dates: [])
    ]
}

extension CarModel {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["type"] = type.rawValue
        repres["title"] = title
        repres["image"] = image
        repres["stateNumber"] = stateNumber
        repres["equipment"] = equipment.map({ item in
            item.rawValue
        })
        repres["description"] = description
        repres["free"] = free
        repres["dates"] = dates.map({ timestamp in
            Timestamp(date: timestamp)
        })
        return repres
    }
}

