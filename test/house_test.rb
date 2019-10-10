require 'minitest/autorun'
require 'pry'
require_relative '../lib/house'
require_relative '../lib/room'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_price
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price
  end

  def test_it_has_address
    house = House.new("$400000", "123 sugar lane")

    assert_equal "123 sugar lane", house.address
  end

  def test_it_starts_with_no_rooms
    house = House.new("$400000", "123 sugar lane")

    assert_equal [], house.rooms
  end

  def test_it_can_add_rooms
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, 13)
    room_2 = Room.new(:bedroom, 11, 15)

    house.add_room(room_2)
    house.add_room(room_1)

    # assert_equal [room_1, room_2], house.rooms
    assert_equal true, house.rooms.include?(room_1)
    assert_equal true, house.rooms.include?(room_2)
  end

  def test_it_gets_rooms_from_category
     house = House.new("$400000", "123 sugar lane")
     room_1 = Room.new(:bedroom, 10, 13)
     room_2 = Room.new(:bedroom, 11, 15)
     room_3 = Room.new(:living_room, 25, 15)
     room_4 = Room.new(:basement, 30, 41)
     house.add_room(room_1)
     house.add_room(room_2)
     house.add_room(room_3)
     house.add_room(room_4)

     assert_equal [room_1, room_2], house.rooms_from_category(:bedroom)
     assert_equal [room_4], house.rooms_from_category(:basement)
     refute_equal [room_4], house.rooms_from_category(:den)
     assert_equal [], house.rooms_from_category(:kitchen)
  end

  def test_it_gets_total_area
     house = House.new("$400000", "123 sugar lane")
     room_1 = Room.new(:bedroom, 10, 13)
     room_2 = Room.new(:bedroom, 11, 15)
     room_3 = Room.new(:living_room, 25, 15)
     room_4 = Room.new(:basement, 30, 41)
     house.add_room(room_1)
     house.add_room(room_2)

     assert_equal 295, house.area

     house.add_room(room_3)
     house.add_room(room_4)

     assert_equal 1900, house.area
  end

  def test_it_gets_price_per_square_foot
     house = House.new("$400000", "123 sugar lane")
     room_1 = Room.new(:bedroom, 10, 13)
     room_2 = Room.new(:bedroom, 11, 15)
     room_3 = Room.new(:living_room, 25, 15)
     room_4 = Room.new(:basement, 30, 41)
     house.add_room(room_1)
     house.add_room(room_2)
     house.add_room(room_3)
     house.add_room(room_4)

     assert_equal 210.53, house.price_per_square_foot
  end

  def test_it_sorts_rooms_by_area
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, 13)
    room_2 = Room.new(:bedroom, 11, 15)
    room_3 = Room.new(:living_room, 25, 15)
    room_4 = Room.new(:basement, 30, 41)
    house.add_room(room_3)
    house.add_room(room_2)
    house.add_room(room_1)
    house.add_room(room_4)

    assert_equal [room_4, room_3, room_2, room_1], house.rooms_sorted_by_area
  end

  def test_it_returns_all_rooms_by_category
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, 13)
    room_2 = Room.new(:bedroom, 11, 15)
    room_3 = Room.new(:living_room, 25, 15)
    room_4 = Room.new(:basement, 30, 41)
    house.add_room(room_3)
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_4)

    expected = {
      basement: [room_4],
      living_room: [room_3],
      bedroom: [room_1, room_2],
    }

    assert_equal expected, house.rooms_by_category
  end
end
