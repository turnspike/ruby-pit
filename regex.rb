#!/usr/bin/env ruby -w
# -*- coding: utf-8 -*-
#
# Author:   Nik Bagdon
# Date:     29/10/2017
# Summary:
#

require "colorize"
require "date"

class PitRegex

  def initialize(args)

  end

  def matchDate

    dates = [
      "1980-01-01",
      "1980-1-01",
      "1980-1-1",
      "1980-13-1",
      "1980-13-01",
      "1980-13-13",
      "1903-01-01",
      "1902-01-01",
      "1901-01-01",
      "1-1-1980",
      "13-13-1980"]

    puts "Validating dates...".light_blue

    dates.each do |date|

      valid = false
      valid = true if valid_date?(date)

      puts "Date #{date} is valid: #{valid}"

    end

  end

  def valid_date?(string)

    # return true if string == "never"

    regex = /^\d{4}-\d{1,2}-\d{1,2}/
    match = regex.match(string)

    return false unless match

    date = Date.parse(string) rescue false

    return false unless date

    cutoff_year = 1903
    return false if date.year < cutoff_year

    return true

  end

  def clean_ldap_dn

    dns = [
      "cn=desk0000,ou=ACTIVE,ou=PEOPLE,o=DATA",
      "        cn=coth0005,ou=ACTIVE,ou=PEOPLE,o=DATA "]

    dns.each do |dn|

      # dn = dn.strip
      # cn = dn[/\Scn=([^,]*)/,0]
      cn = dn[/cn=([^,]*)/, 1]
      puts "#{dn} -> #{cn}"

    end

  end

  def run # main method

    # self.intersect
    # self.matchDate
    self.clean_ldap_dn

  end

end

if __FILE__ == $PROGRAM_NAME # running as "ruby main.rb"

  pit = PitRegex.new(ARGV)
  pit.run

end
