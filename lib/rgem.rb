require 'rbconfig'
require 'json'
require "rgem/version"
require "rgem/request"
require "rgem/parser"

module Rgem
  GEMFILE = "Gemfile"
  API_URL = "https://rgem-api.herokuapp.com"

  def self.list_gems(project_path)
    gem_file_path  = get_gem_file_path project_path
    gems = Parser.parse gem_file_path
    os_info = get_os_info
    response = Request.post("#{API_URL}/api/gems/many/list", { gems: gems, os_info: os_info })
    JSON.parse(response.body)
  end

  def self.install_gems(project_path)
    sys_dep = []
    gems = list_gems project_path
    gems.each do |gem|
      sys_dep = sys_dep + gem["sysDep"]
    end
    install sys_dep
  end

  def self.install(gems)
    cmd = "sudo apt install ";
    gems.each do |gem| cmd += gem + " " end
    puts cmd
    system(cmd)
  end

  def self.get_gem_file_path(project_path)
    project_path = Dir.getwd() if !project_path
    File.absolute_path(GEMFILE, project_path)
  end

  def self.get_os_info
    os_info = {}
    os_info["os"] = RbConfig::CONFIG["target_os"]
    os_info["cpu"] = RbConfig::CONFIG["target_cpu"]
    os_info
  end

end
