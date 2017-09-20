class Spree::Report::TimedObservation < Spree::Report::Observation

  extend Forwardable

  attr_accessor :date, :hour, :reportable_keys

  def_delegators :date, :day, :month, :year

  def initialize
    super
    self.hour = 0
  end

  def describes?(result, time_scale)
    case time_scale
    when :hourly
      result['hour'] == hour && result['day'] == day
    when :daily
      result['day'] == day && result['month'] == month
    when :monthly
      result['month'] == month && result['year'] == year
    when :yearly
      result['year'] == year
    end
  end

  def month_name
    Date::MONTHNAMES[month]
  end

  def hour_name
    if hour == 23
      return "23:00 - 00:00"
    else
      return "#{ hour }:00 - #{ hour + 1 }:00"
    end
  end

  def day_name
    "#{ day } #{ month_name }"
  end

  def to_h
    super.merge({day_name: day_name, month_name: month_name, year: year, hour_name: hour_name})
  end

end
