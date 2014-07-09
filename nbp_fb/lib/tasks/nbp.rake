namespace :nbp do

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
            series.title = line.gsub('series:', '').strip
            puts series.title + ' Retrieved'
          end
          if line_array[0] == 'prefix:'
            puts line
            author.prefix = line.gsub('prefix:', '').strip
            puts author.prefix + ' Retrieved'
          end
          if line_array[0] == 'first_name:'
            puts line
            author.first_name = line.gsub('first_name:', '').strip
            puts author.first_name + ' Retrieved'
          end
          if line_array[0] == 'middle_name:'
            puts line
            author.middle_name = line.gsub('middle_name:', '').strip
            puts author.middle_name + ' Retrieved'
          end
          if line_array[0] == 'last_name:'
            puts line
            author.last_name = line.gsub('last_name:', '').strip
            puts author.last_name + ' Retrieved'
          end
          if line_array[0] == 'suffix:'
            puts line
            author.suffix = line.gsub('suffix:', '').strip
            puts author.suffix + ' Retrieved'
          end
          if line[0].to_i > 0
            puts line
            sequence_number = line_array[0].gsub('.', '').chomp.to_i
            puts sequence_number.to_s + ' Is the sequence number'
            book_title = line.gsub(sequence_number.to_s + '.', '').strip
            puts book_title + ' Is the book title retrieved'
            books << Book.new(sequence_number:sequence_number, title:book_title)
            puts book_title + ' Added to the books Array!'
          end
          if line_array[0] == 'notes:'
            puts line
            series.notes = line.gsub('notes:', '').strip
            puts series.notes
            puts 'Series Notes Retrieved!'
          end
      end
      f.close
      puts 'File closed!'
      puts 'Preparing to save.'
      author_test = Author.where(prefix: author.prefix, first_name: author.first_name, middle_name: author.middle_name, last_name: author.last_name, suffix: author.suffix).first
      if author_test.blank?
        series.books << books
        author.series << series
        if author.save
          puts ' New Author Saved Successfully!'
        else
          puts 'There was a problem saving.'
        end
      else
        series_test = Series.where(title: series.title).first
        if series_test.blank?
          series.books << books
          author_test.series << series
          if author_test.save
            puts 'New Series Saved successfully on existing Author!'
          else
            puts 'There was a problem saving new Series'
          end
        end
      end
    end #end loop through files
    
  end #end import_book_series

  

end #end namespace nbp
