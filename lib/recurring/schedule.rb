module Recur
  class Schedule
    attr_reader :scd_elems

    def initialize
      @scd_elems = []
    end

    def add_elem(schedule_elem)
      @scd_elems << schedule_elem
    end

    def occurrences evt_arg, date_range
      res = []
      @scd_elems.each do |scd_elem|
        ocrs = scd_elem.occurrences evt_arg, date_range
        res << ocrs unless ocrs.nil?
      end
      res
    end

    def next_occurrence evt_arg, date
      @scd_elems.each do |scd_elem|
        next_ocr = scd_elem.next_occurrence evt_arg, date
        return next_ocr unless next_ocr
      end
    end

    def is_occurring evt_arg, date
      @scd_elems.each do |scd_elem|
        if scd_elem.is_occurring evt_arg, date
          return true
        end
      end
      false
    end
  end
end
