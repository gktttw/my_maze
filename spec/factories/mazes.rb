FactoryBot.define do
  factory :maze do
    size { 5 }
    grid { Array.new(size) { Array.new(size) { rand(0..1) } }.to_json }
    solution { Array.new(size) { Array.new(size) { rand(0..1) } }.to_json }
  end
end
