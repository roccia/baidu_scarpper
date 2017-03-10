require 'rubygems'
require 'pdf/reader'
require 'elasticsearch/persistence'

class PdfTest

  repository = Elasticsearch::Persistence::Repository.new
  reader = PDF::Reader.new("国泰君安：2016年第一季度报告.pdf")
  reader.pages.each do |page|
    file =  page.text
    note = {id:'1' , text:file}
    repository.save(note)
    p n = repository.find(1)
  p  repository.search(query: { match: { text: file } }).first

  end

end