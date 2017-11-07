#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Author:   Nik Bagdon
# Date:     5/11/2017
# Summary:
#

require "colorize"
require "date"

class PitDates

  def initialize(args)

  end

  def datestr_to_obj(string)

    return false unless valid_date?(string)
    return Date.parse(string)

  end

  def dateobj_to_str(date)

    return false unless date
    return date.strftime("%Y-%m-%d")

  end

  def valid_date?(string)

    # -- fail if string doesn't match date pattern
    regex = /^\d{4}-\d{1,2}-\d{1,2}/
    match = regex.match(string)
    return false unless match

    # -- fail if string can't be parsed into a date object
    date = Date.parse(string) rescue false
    return false unless date

    # -- year of birth must be newer than 1903
    cutoff_year = 1903
    return false if date.year < cutoff_year

    return true

  end

  def chunks(string)

    dob = string.strip
    chunks = dob.split("-")

    year = chunks[0]
    month = chunks[1]
    day = chunks[2]

    puts "#{day}\t#{month}\t#{year}"
    puts "#{day.length}\t#{month.length}\t#{year.length}"

    if month.length < 2

      month.prepend("0")
      puts "Pad de month: #{month}"

    end
  end

  def subtract_year

    date = datestr_to_obj("2016-10-02")
    puts date.year
    date = date - 365
    puts date.year
    puts dateobj_to_string(date)

  end

  def chunk_checker

    chunks("1980-01-23")
    chunks("1980-1-23")

  end

  def run # main method


    # subtract_year
    chunk_checker


  end

end

if __FILE__ == $PROGRAM_NAME # running as "ruby main.rb"

  pit = PitDates.new(ARGV)
  pit.run

end
