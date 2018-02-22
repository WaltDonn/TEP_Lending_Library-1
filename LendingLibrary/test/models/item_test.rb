require 'test_helper'

class ItemTest < ActiveSupport::TestCase
# test validations
	def setup
		@item = items(:one)
	end

	test 'valid item' do
		assert @item.valid?
	end

	test 'invalid without readable id' do
		@item.readable_id = nil
		refute @item.valid?
	end

	test 'invalid without condition' do
		@item.condition = nil
		refute @item.valid?
	end

	test 'invalid without category' do
		@item.item_category_id = nil
		refute @item.valid?
	end

	test 'condition must be Good or Broken' do
		@item.condition = "Good"
		assert @item.valid?
		@item.condition = "Broken"
		assert @item.valid?
		@item.condition = "Else"
		refute @item.valid?
		@item.condition = 123
		refute @item.valid?
	end
end
