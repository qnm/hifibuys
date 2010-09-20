# app/views/layouts/application.rss.builder
xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0', 'xmlns:g' => 'http://base.google.com/ns/1.0', 'xmlns:c'  => 'http://base.google.com/cns/1.0' do
  xml << yield
end
