require 'rails_helper'

RSpec.describe Product, type: :model do


  describe 'Validations' do
    before (:each) do
      @category = Category.create!(name: 'Toy')
    end

    it 'should create a product when four validates are enteired' do
      @product = Product.create!(name: 'Paper Tower', price: 26, quantity:12, category: @category)
      expect(@product.valid?).to be true
    end

    it 'should not be allowed to create a product without name' do
      @product = Product.new(price: 26, quantity:12, category: @category)
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Name can\'t be blank")
    end

    it 'should not be allowed to create a product without price' do
      @product = Product.new(name: 'Paper Tower', quantity:12, category: @category)
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Price can\'t be blank")
    end

    it 'should not be allowed to create a product without price' do
      @product = Product.new(name: 'Paper Tower', price: 26, category: @category)
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Quantity can\'t be blank")
    end

    it 'should not be allowed to create a product without price' do
      @product = Product.new(name: 'Paper Tower', price: 26, quantity:12)
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Category can\'t be blank")
    end
  end



end
