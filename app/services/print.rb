class Print
  def initialize(trips)
    @trips = trips
  end

  def perform
    @trips.all.each do |trip|
      trip.reservation_segments.order('rank, DATE(start_at)').each_with_index do |segment, index|
        
        print "Trip to #{segment.trip.city.code}\n" if index == 0
        case segment.segment_type
        when -> (n) { Trip.RESERVATION_TYPES[:transportation].include?(n)}
          print "#{segment.segment_type} from #{segment.origin} to #{segment.destination} at #{segment.start_at.strftime('%Y-%m-%d %H:%M')} to #{segment.start_at.strftime('%H:%M')}\n"
        when -> (n) { Trip.RESERVATION_TYPES[:other].include?(n)}
          print "#{segment.segment_type} at #{segment.origin} on #{segment.start_at.strftime('%Y-%m-%d')} to #{segment.end_at.strftime('%Y-%m-%d')}\n"
          return "#{segment.segment_type} from #{segment.origin} to #{segment.destination} at #{segment.start_at.strftime('%Y-%m-%d %H:%M')} to #{segment.start_at.strftime('%H:%M')}\n"
        end
      end 
      print "\n"
    end
  end
end