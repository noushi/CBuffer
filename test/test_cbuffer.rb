require 'helper'

# TODO raise on buffer max flag

class TestCBuffer < Test::Unit::TestCase
  def test_basics
    b = Cbuffer.new(3)
    assert !b.full?
    assert b.empty?
    assert_equal 3, b.size
    assert b.get.nil? 
    b.put "Duncan"
    b.put "Ellen"
    assert !b.full?
    assert_equal ["Duncan","Ellen"], b.elements
    b.put "Hugh"
    b.put "Ed"
    assert_equal ["Ed", "Ellen", "Hugh"], b.elements
    assert !b.empty?
    assert b.full?
    assert_equal "Ellen", b.get 
    assert_equal "Hugh", b.get
  end

  def test_large_buffer
    b = Cbuffer.new(1000)
    b.put 1
    b.put 2
    b.put 3
    b.put 4
    b.put 5
    b.put 6
    assert !b.full?
    assert !b.empty?
    assert_equal b.get, 1
    assert_equal b.get, 2
    assert_equal b.get, 3
    assert_equal b.get, 4
    assert_equal b.get, 5
    assert !b.empty?
    assert_equal b.get, 6
    assert b.empty?
    b.put 3
    b.put 4
    b.put 5
    b.put 6
    assert !b.full?
    assert !b.empty?
    assert_equal b.get, 3
    assert_equal b.get, 4
    assert_equal b.get, 5
    assert_equal b.get, 6
  end

  def test_addding_nil
    b = Cbuffer.new(10)
    assert !b.full?
    assert b.empty?
    b.put nil
    assert !b.empty?
  end
end