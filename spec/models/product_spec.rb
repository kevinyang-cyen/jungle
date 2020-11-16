require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    Product.destroy_all
    Category.destroy_all

    it "saves name, price, quantity, and category successfully" do
      cat1 = Category.find_or_create_by! name: 'Cat1'
      prod1 = cat1.products.create!({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(prod1.name).to eq('Men\'s Classy shirt')
      expect(prod1.price).to eq(64.99)
      expect(prod1.quantity).to eq(10)
      expect(prod1.category_id).to eq(cat1.id)
    end

    it "checks if name is entered" do
      cat2 = Category.find_or_create_by! name: 'Cat2'
      prod2 = cat2.products.create({
        name:  nil,
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(prod2.errors.full_messages).to include("Name can't be blank")
    end

    it "checks if price is entered" do
      cat3 = Category.find_or_create_by! name: 'Cat3'
      prod3 = cat3.products.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: nil
      })
      expect(prod3.errors.full_messages).to include("Price can't be blank")
    end

    it "checks if quantity is entered" do
      cat4 = Category.find_or_create_by! name: 'Cat4'
      prod4 = cat4.products.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: nil,
        price: 64.99
      })
      expect(prod4.errors.full_messages).to include("Quantity can't be blank")
    end

    it "checks if category_id exists" do
      prod5 = Product.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(prod5.errors.full_messages).to include("Category can't be blank")
    end

  end
end