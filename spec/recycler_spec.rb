require_relative 'spec_helper'

describe Recycler do
  before :each do
    @recycler = Recycler.new
  end

  it 'should have no bottles to begin with' do
    expect(@recycler.total_bottles).to eq 0
  end

  describe '#purchase_bottles_with_money' do
    it 'returns 2 bottles when the user inputs 4 dollars' do
      @recycler.money = 4
      @recycler.send(:purchase_bottles_with_money)
      expect(@recycler.purchased_bottles).to eq 2
    end
  end

  describe '#recycle_initial_purchase' do
    it 'returns 17 bottle caps and 17 empty bottles when you recycle 17 purchased bottles' do
      @recycler.purchased_bottles = 17
      @recycler.send(:recycle_initial_purchase)
      expect(@recycler.bottle_caps).to eq 17
      expect(@recycler.empty_bottles).to eq 17
    end
    it 'returns 3 non-redeemable extra bottle caps but and 3 empty bottles but no non-redeemable empty bottles with 3 purchased bottles' do
      @recycler.purchased_bottles = 3
      @recycler.send(:recycle_initial_purchase)
      expect(@recycler.extra_bottle_caps).to eq 3
      expect(@recycler.bottle_caps).to eq 3
      expect(@recycler.extra_empty_bottles).to eq 0
      expect(@recycler.empty_bottles).to eq 3
    end
  end

  describe '#redeem_bottles_from_bottle_caps' do
    it 'returns 4 bottles from bottle caps if there are 16 bottle caps' do
      @recycler.bottle_caps = 16
      @recycler.send(:redeem_bottles_from_bottle_caps)
      expect(@recycler.bottles_from_bottle_caps).to eq 4
    end
    it 'returns 3 extra bottle caps if there are 7 bottle caps' do
      @recycler.bottle_caps = 7
      @recycler.send(:redeem_bottles_from_bottle_caps)
      expect(@recycler.extra_bottle_caps).to eq 3
    end
  end

  describe '#not_enough_bottle_caps' do
    it 'returns true if there are 3 bottle caps' do
      @recycler.bottle_caps = 3
      expect(@recycler.send(:not_enough_bottle_caps)).to eq true
    end
    it 'returns false if there are 4 bottle caps' do
      @recycler.bottle_caps = 4
      expect(@recycler.send(:not_enough_bottle_caps)).to eq false
    end
  end

  describe '#not_enough_empty_bottles' do
    it 'returns true if there is 1 empty bottle' do
      @recycler.empty_bottles = 1
      expect(@recycler.send(:not_enough_empty_bottles)).to eq true
    end
    it 'returns false if there are 2 empty bottles' do
      @recycler.empty_bottles = 2
      expect(@recycler.send(:not_enough_empty_bottles)).to eq false
    end
  end

  describe '#update_total_bottles' do
    it 'returns 8 total bottles when purchased bottles is 8' do
      @recycler.purchased_bottles = 8
      @recycler.bottles_from_empty_bottles = 0
      @recycler.bottles_from_bottle_caps = 0
      @recycler.send(:update_total_bottles)
      expect(@recycler.total_bottles).to eq 8
    end
    it 'returns 10 total bottles when purchased bottles is 6, bottles from empty bottles is 3, and bottles from bottle caps are 1' do
      @recycler.purchased_bottles = 6
      @recycler.bottles_from_empty_bottles = 3
      @recycler.bottles_from_bottle_caps = 1
      @recycler.send(:update_total_bottles)
      expect(@recycler.total_bottles).to eq 10
    end
  end

end