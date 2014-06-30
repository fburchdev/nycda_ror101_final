namespace :nbp do
  @series_file

  def read_file(file_name)
    f = File.open(file_name, "r")
    f.each_line do |line|
      #puts line
      line.split(" ")
      puts line[0]
    end
    f.close
    puts 'Fin'
  end

  def get_author
  	author = Author.new
  	@series_file.each_line do |line|
  		line_array = line.split(' ')
      name_part = line_array[0]
      case name_part
      when 'prefix:' then author.prefix = line_array[1]
      when 'first_name:' then author.first_name = line_array[1]
      when 'middle_name:' then author.middle_name = line_array[1]
      when 'last_name:' then author.last_name = line_array[1]
      when 'suffix:' then author.suffix = line_array[1]
      end
  	end
  	return author
  end


  desc "Import book series data from files in .series format."
  task import_book_series: :environment do
  	path = Rails.root.join('lib/book_series').to_s
    Dir.glob(path + '/*.series').each do|f|
      @series_file = File.open(f, 'r')
      author = get_author
      puts author.prefix
      puts author.first_name
      puts author.middle_name
      puts author.last_name
      puts author.suffix
      @series_file.close
    end
  end #end import_book_series

end
