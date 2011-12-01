require 'document/reporter/builder'
module Reporter
  class Base
    def self.find(attributes={})
      @reporter = new(attributes)
      @reporter
    end

    def initialize(attributes={})
      @start_date = attributes[:start_date]
      @end_date = attributes[:end_date]
      @attributes = extract_options(attributes)
      @report = Reporter::Builder.new
    end

    def all
      @report.sections.collect do |section|
        collections = subsections(section)
        if collections.is_a? Array and collections.size > 0
          { :title => I18n.t("reporter.#{section.title}"), :subsections => collections }
        end
      end.compact
    end

    private
    def subsections(section)
      section.sections.collect do |subsection|
        records = collection(subsection)
        if records.is_a? Array and records.size > 0
          { :title => I18n.t("reporter.#{subsection.title}"), :collection => records }
        end
      end.compact
    end

    def collection(subsection)
      if subsection.date_style == :date_disabled
        subsection.all
      else
        subsection.search(date_options(subsection).merge @attributes)
      end
    end

    def extract_options(attributes)
      attributes.delete :start_date
      attributes.delete :end_date
      attributes
    end

    def date_options(subsection)
      self.send subsection.date_style
    end

    def date
      # Define the scope between in your model, for example: app/models/newspaperarticle
      { :between => [start_date, end_date] }
    end

    def month_and_year
       { :since => [ start_date.year, start_date.month ], :until => [ end_date.year, end_date.month ] }
    end

    def only_year
      { :between => [start_date.year, end_date.year] }
    end

    def date_range
       { :since =>  start_date, :until => end_date }
    end

    def start_date
       Date.parse(@start_date) or (Date.today - 1)
    end

    def end_date
      Date.parse(@end_date) or Date.today
    end
  end
end
