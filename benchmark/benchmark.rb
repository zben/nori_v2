$:.push File.expand_path("../../lib", __FILE__)
require "nori_v2"

require "benchmark"

Benchmark.bm 30 do |x|

  num = 500
  xml = File.read File.expand_path("../soap_response.xml", __FILE__)

  x.report "rexml parser" do
    num.times { NoriV2.new(parser: :rexml).parse xml }
  end

  x.report "nokogiri parser" do
    num.times { NoriV2.new(parser: :nokogiri).parse xml }
  end

end
