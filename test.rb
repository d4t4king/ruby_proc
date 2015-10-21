#!/usr/bin/env ruby

require 'rubygems'
require 'pp'
require 'colorize'

require_relative './Proc.rb'

p = Proc::CpuInfo.new()

pp p


