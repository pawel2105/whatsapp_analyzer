Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each do |file|
  require file
end