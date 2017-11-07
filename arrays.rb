#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Author:   Nik Bagdon
# Date:     29/10/2017
# Summary:
#

require "colorize"

class PitArrays

  def initialize(args)

  end

  def main

    conn = connect(settings)

  end

  def connect(settings) # return a LDAP connection, or false if connection failed

    conn = Net::LDAP.new :host => settings.server,
      :port => settings.port,
      :auth => { :method => :simple,
      :username => settings.username,
      :password => settings.password }

    return conn if conn.bind
    return false

  rescue Net::LDAP::LdapError => e # FIXME this doesn't catch DNS errors?

    puts "Exception Class: #{ e.class.name }"
    puts "Exception Message: #{ e.message }"
    puts "Exception Backtrace: #{ e.backtrace }"
    puts conn.get_operation_result.to_s

    return false

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


    hashes = [hash1, hash2, hash3]
    uniques = Array.new
    # puts hashes.select { |hash| uniques | hash.keys }

    # uniques = hashes.select { |hash|  }

    hashes.each { |hash| uniques = uniques | hash.keys }

    # hashes.each do |hash|

    #   puts "#{hash.keys}..."
    #   uniques = uniques | hash.keys

    # end

    puts "Uniques: #{uniques}"

  end

  def exact_match_or_strict_subset

    reference = %w(Generic External)

    puts "Reference: #{reference}"

    arrays = [
      ["Generic"],
      ["External"],
      ["Generic", "External"],
      ["External", "Generic"],
      ["Wigwam"],
      ["Something", "Generic"],
      ["External", "Wigwam"],
      ["Generic", "External", "Qwijibo"],
      nil,
      []
    ]

    arrays.each do |array|

      puts "Testing array: #{array}".light_blue
      if array.to_a.empty?

        puts "Empty array, fail".red
        next

      end

      extra_roles = array - reference
      if !extra_roles.empty?

        puts "Array has extra roles not present in reference array, fail".red
        next

      end

      puts "That's a match!".green

    end

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
    #self.enumerate
    # self.build_unique
    self.exact_match_or_strict_subset

  end

end

if __FILE__ == $PROGRAM_NAME # running as "ruby main.rb"

  pit = PitArrays.new(ARGV)
  pit.run

end
