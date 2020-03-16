module BootstrapForm
  class FormBuilder
    def default_label_col
      'col-sm-2 text-right'
    end
    def default_control_col
      'col-sm-10'
    end
    def default_layout
      # :default, :horizontal or :inline
      :horizontal
    end
  end
end