require "sinatra"
require "haml"
require "sinatra/json"
require "open-uri"
require "tmpdir"
require "poppler"

get "/" do
  haml :index
end

get "/json" do
  pages = []
  Dir.mktmpdir do |tmpdir|
    path = File.join(tmpdir, "source.pdf")
    open(params[:uri]) do |source|
      File.open(path, "wb") do |file|
        file.write(source.read)
      end
    end
    document = Poppler::Document.new(path)
    document.each do |page|
      pages << page.get_text
    end
  end
  json pages
end
