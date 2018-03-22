module Rgem
  module Parser

    def self.parse(gem_file_path)
      gems = []
      gem_file = File.open(gem_file_path, "r")
      gem_file.each_line do |line|
        line.strip!
        items = line.split(" ")
        if items[0] == "gem"
          gems.push(items[1..2])
        end
      end
      gem_file.close
      refine_gems_arr gems
      gems
    end

    def self.refine_gems_arr(gems)
      gems.each do |gem|
        gem.each do |str|
          str.gsub!(/\'|\,/, '')
        end
      end
    end

  end
end
