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
    author = Author.where(prefix: author.prefix, first_name: author.first_name, middle_name: author.middle_name, last_name: author.last_name, suffix: author.suffix).first_or_initialize
    return author
  end

  def get_series
    puts 'EXECUTING get_series'
    series = Series.new
    @series_file.each_line do |line|
      line_array = line.split(' ')
      if line_array[0] == 'series:'
        series.title = line_array[1].chomp
      end
      if line_array[0] == 'notes:'
        series.notes = line_array[1].chomp
      end
    end
    return series
  end

  def get_books
    books = Array.new
    @series_file.each_line do |line|
      if line[0].to_i > 0
        line_array = line.split(' ')
        book = Book.new
        book.sequence_number = line_array[0].gsub('.', '').chomp.to_i
        book.title = line.gsub(line_array[0], '').chomp
        books << book 
      end
    end
    return books
  end

  desc "Import book series data from files in .series format."
  task import_book_series: :environment do
    path = Rails.root.join('lib/book_series').to_s
    Dir.glob(path + '/*.series').each do |f|
      puts f + ' Is the file name'
      author = Author.new
      series = Series.new
      books = Array.new
      f = File.open(f, "r")
      f.each_line do |line|
        line_array = line.split(' ')
          if line_array[0] == 'series:'
            series.title = line.gsub('series:', '').chomp
            puts series.title + ' Retrieved'
          end
          if line_array[0] == 'first_name:'
            puts line
            author.first_name = line.gsub('first_name:', '').chomp
            puts author.first_name + ' Retrieved'
          end
      end
      f.close
      puts 'File closed!'
    end #end loop through files
    
  end #end import_book_series

  desc "OLD IMPORT TASK TO BE REWORKED"
  task import_book_series_old: :environment do
  	path = Rails.root.join('lib/book_series').to_s
    Dir.glob(path + '/*.series').each do|f|
      @series_file = File.open(f, 'r')
      author = get_author
      series = get_series

      if author.id.to_i == 0
        puts Author.get_name(author) + ' TESTING'
        series.books << get_books
        author.series << series 
        if author.save
         puts Author.get_name(author) + ' Saved!'
        else
         puts 'Error Saving Author!'
        end
      else
        series = Series.where(title: series.title, author_id: author.id).first_or_initialize
        if series.id > 0
          puts series.title + ' Series already exists. No need to save.'
        else
          series.books << get_books
          author.series << series
          if author.save
            puts Author.get_name(author) + ' Saved!'
          else
            puts 'Problem saving Author!'
          end
        end
      end
      @series_file.close
    end #end loop through series files
  end #end import_book_series_old

end #end namespace nbp
