class House
  attr_reader :address, :rooms

  def initialize(price, address)
    @price = price
    @address = address
    @rooms = []
  end

  def price
    @price.gsub("$", "").to_i
  end

  def add_room(room)
    @rooms << room
  end

  def rooms_from_category(category)
    # @rooms.map do |room|
    #   if room.category == category
    #     room
    #   end
    # end.compact

    @rooms.find_all do |room|
      room.category == category
    end
  end

  def area
    # sum = 0
    # @rooms.each do |room|
    #   sum += room.area
    # end
    # sum

    # @rooms.map do |room|
    #   room.area
    # end.sum

    @rooms.sum { |room| room.area }

    # @rooms.sum(&:area)
  end

  def price_per_square_foot
    (price / area.to_f).round(2)
  end

  def rooms_sorted_by_area
    @rooms.sort_by do |room|
      room.area
    end.reverse
  end

  def rooms_by_category
    # rooms = {}
    # @rooms.each do |room|
    #   if rooms[room.category]
    #     rooms[room.category] << room
    #   else
    #     rooms[room.category] = [room]
    #   end
    # end
    # rooms

    # @rooms.inject({}) do |grouped_rooms, room|
    #   if grouped_rooms[room.category]
    #     grouped_rooms[room.category] << room
    #   else
    #     grouped_rooms[room.category] = [room]
    #   end
    #   grouped_rooms
    # end

    @rooms.group_by do |room|
      room.category
    end
  end
end
