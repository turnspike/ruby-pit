#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Author:   Nik Bagdon
# Date:     2/11/2017
# Summary:
#

require "colorize"

class Ldap

  def initialize(args)

  end

  def intersect

    whitelist = %w(Alpha Beta Gamma Delta Echo)
    compare = {
      :compare1 => %w(Delta Beta),
      :compare2 => %w(Apple Banana Pear),
      :compare3 => %w(Banana Delta)
    }

    puts "whitelist:".blue
    puts "\t#{whitelist}"

    compare.each do |name, item|

      puts "#{name}:".blue
      puts "\t#{item}"

      if !(whitelist & item).empty?

        puts "\intersects".green

      else

        puts "\doesn't intersect".red

      end

    end

  end

  def wrap

    string = "A stringly string"

    hash = Hash.new

    hash[:key] = Array(string)

    puts hash[:key].first

  end

  def enumerate

    array1 = %w(Alpha Beta Gamma Delta)
    array2 = %w(Beta)

    puts array1.select{ |item| array2.include? item }

  end

  def build_unique


    hash1 = {
      "alpha" => "apple",
      "bravo" => "banana",
      "charlie" => "carrot",
      "delta" => "durian"
    }

    hash2 = {
      "bravo" => "bear",
      "zulu" => "zebra",
      "delta" => "dog"
    }

    hash3 = {
      "qijibo" => "purple monkey dishwasher"
    }


    uniques = Array.new




  end

  def mapTest?(string)

    regex = /^Al/
    return match = regex.match(string)

  end

  def valid_date?(string)

    # return true if string == "never"

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

  def run # main method

    # self.intersect
    # self.wrap
    self.enumerate

  end

end

if __FILE__ == $PROGRAM_NAME # running as "ruby main.rb"

  pit = PitArrays.new(ARGV)
  pit.run

end
