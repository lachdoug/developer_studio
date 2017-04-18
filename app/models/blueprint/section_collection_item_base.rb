module Blueprint
  module SectionCollectionItemBase

    attr_accessor :index, :new_record
    attr_reader :blueprint_section

    def to_s
      name || 'New'
    end

    def disable_moveup
      index == 0 || new_record
    end

    def update(params)
      assign_attributes params
      blueprint_section.save
    end

  end
end
