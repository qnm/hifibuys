VCR.configure do |c|
  c.hook_into :fakeweb
  c.cassette_library_dir = 'spec/cassettes'
end
