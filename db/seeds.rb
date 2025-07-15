# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 브랜드 데이터 생성
brands_data = [
  {
    name: 'Honda',
    description: '일본의 대표적인 오토바이 제조업체로, 안정성과 연비로 유명합니다.',
    founded_year: 1948,
    country: 'Japan',
    category: 'motorcycle',
    website: 'https://www.honda.co.kr'
  },
  {
    name: 'Yamaha',
    description: '스포츠 바이크와 크루저 바이크로 유명한 일본 브랜드입니다.',
    founded_year: 1955,
    country: 'Japan',
    category: 'motorcycle',
    website: 'https://www.yamaha-motor.co.kr'
  },
  {
    name: 'BMW',
    description: '독일의 프리미엄 오토바이 브랜드로, 고성능과 안전성을 중시합니다.',
    founded_year: 1916,
    country: 'Germany',
    category: 'motorcycle',
    website: 'https://www.bmw-motorrad.co.kr'
  },
  {
    name: 'Ducati',
    description: '이탈리아의 고성능 스포츠 바이크 전문 제조업체입니다.',
    founded_year: 1926,
    country: 'Italy',
    category: 'motorcycle',
    website: 'https://www.ducati.com'
  },
  {
    name: 'Harley-Davidson',
    description: '미국의 전통적인 크루저 바이크 제조업체입니다.',
    founded_year: 1903,
    country: 'USA',
    category: 'motorcycle',
    website: 'https://www.harley-davidson.com'
  },
  {
    name: 'Trek',
    description: '미국의 프리미엄 자전거 브랜드로, 다양한 라이딩을 위한 자전거를 제공합니다.',
    founded_year: 1976,
    country: 'USA',
    category: 'bicycle',
    website: 'https://www.trekbikes.com'
  },
  {
    name: 'Specialized',
    description: '고성능 로드 바이크와 MTB로 유명한 미국 브랜드입니다.',
    founded_year: 1974,
    country: 'USA',
    category: 'bicycle',
    website: 'https://www.specialized.com'
  },
  {
    name: 'Giant',
    description: '대만의 세계적인 자전거 제조업체로, 합리적인 가격의 고품질 자전거를 제공합니다.',
    founded_year: 1972,
    country: 'Taiwan',
    category: 'bicycle',
    website: 'https://www.giant-bicycles.com'
  },
  {
    name: 'Cannondale',
    description: '혁신적인 디자인과 기술로 유명한 미국 자전거 브랜드입니다.',
    founded_year: 1971,
    country: 'USA',
    category: 'bicycle',
    website: 'https://www.cannondale.com'
  },
  {
    name: 'Kawasaki',
    description: '일본의 다목적 오토바이 제조업체로, 스포츠 바이크와 투어링 바이크를 전문으로 합니다.',
    founded_year: 1896,
    country: 'Japan',
    category: 'motorcycle',
    website: 'https://www.kawasaki.co.kr'
  }
]

# 브랜드 생성
brands_data.each do |brand_data|
  Brand.find_or_create_by(name: brand_data[:name]) do |brand|
    brand.assign_attributes(brand_data)
  end
end

# 모델 데이터 생성
models_data = [
  # Honda 모델들
  {
    brand_name: 'Honda',
    name: 'CBR1000RR',
    year: 2024,
    category: 'motorcycle',
    price: 25000000,
    engine_displacement: 1000,
    weight: 201,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'Red, Black, White',
    specifications: {
      power: '217 hp',
      torque: '113 Nm',
      top_speed: '299 km/h'
    }
  },
  {
    brand_name: 'Honda',
    name: 'CB650R',
    year: 2024,
    category: 'motorcycle',
    price: 12000000,
    engine_displacement: 649,
    weight: 202,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'Red, Black, Blue',
    specifications: {
      power: '95 hp',
      torque: '60 Nm',
      top_speed: '220 km/h'
    }
  },
  # Yamaha 모델들
  {
    brand_name: 'Yamaha',
    name: 'YZF-R1',
    year: 2024,
    category: 'motorcycle',
    price: 28000000,
    engine_displacement: 998,
    weight: 199,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'Blue, Black, Red',
    specifications: {
      power: '200 hp',
      torque: '113 Nm',
      top_speed: '299 km/h'
    }
  },
  {
    brand_name: 'Yamaha',
    name: 'MT-07',
    year: 2024,
    category: 'motorcycle',
    price: 9500000,
    engine_displacement: 689,
    weight: 184,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'Black, Blue, Red',
    specifications: {
      power: '74 hp',
      torque: '68 Nm',
      top_speed: '200 km/h'
    }
  },
  # BMW 모델들
  {
    brand_name: 'BMW',
    name: 'S1000RR',
    year: 2024,
    category: 'motorcycle',
    price: 32000000,
    engine_displacement: 999,
    weight: 197,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'White, Black, Red',
    specifications: {
      power: '205 hp',
      torque: '113 Nm',
      top_speed: '299 km/h'
    }
  },
  {
    brand_name: 'BMW',
    name: 'R1250GS',
    year: 2024,
    category: 'motorcycle',
    price: 28000000,
    engine_displacement: 1254,
    weight: 249,
    fuel_type: 'Gasoline',
    transmission: '6-speed manual',
    colors: 'Blue, Black, White',
    specifications: {
      power: '136 hp',
      torque: '143 Nm',
      top_speed: '200 km/h'
    }
  },
  # 자전거 모델들
  {
    brand_name: 'Trek',
    name: 'Domane SLR',
    year: 2024,
    category: 'bicycle',
    price: 8500000,
    weight: 8.5,
    fuel_type: 'Human Power',
    transmission: 'Electronic',
    colors: 'Black, Red, Blue',
    specifications: {
      frame_material: 'Carbon Fiber',
      groupset: 'Shimano Dura-Ace',
      wheel_size: '700c'
    }
  },
  {
    brand_name: 'Specialized',
    name: 'Tarmac SL7',
    year: 2024,
    category: 'bicycle',
    price: 9200000,
    weight: 7.8,
    fuel_type: 'Human Power',
    transmission: 'Electronic',
    colors: 'White, Black, Red',
    specifications: {
      frame_material: 'Carbon Fiber',
      groupset: 'SRAM Red eTap',
      wheel_size: '700c'
    }
  }
]

# 모델 생성
models_data.each do |model_data|
  brand = Brand.find_by(name: model_data[:brand_name])
  next unless brand
  
  Model.find_or_create_by(name: model_data[:name], brand: brand, year: model_data[:year]) do |model|
    model.assign_attributes(model_data.except(:brand_name))
  end
end

puts "시드 데이터 생성 완료!"
puts "생성된 브랜드: #{Brand.count}개"
puts "생성된 모델: #{Model.count}개"
