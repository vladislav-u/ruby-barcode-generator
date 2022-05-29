require 'fox16'
require 'fox16/colors'
require './barcode_generator'
include Fox

class Window < FXMainWindow
  def initialize(app)
    super(app, 'Barcode Generator', width: 600, height: 400)
    init
  end

  def create
    super
    show(PLACEMENT_SCREEN)
    on_click_button
  end

  private

  def init
    init_layout
    init_labels
    init_combo_box
    init_text
    init_button
    init_generator
  end

  def init_layout
    packer = FXPacker.new(self, opts: LAYOUT_FILL)
    group_box = FXGroupBox.new(packer, nil, opts: LAYOUT_FILL)
    v_frame = FXVerticalFrame.new(group_box, opts: LAYOUT_FILL)

    @select_h_frame = FXHorizontalFrame.new(v_frame, opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y | PACK_UNIFORM_WIDTH, hSpacing: 70)
    @info_h_frame = FXHorizontalFrame.new(v_frame, opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y | PACK_UNIFORM_WIDTH, hSpacing: 70)
    @name_h_frame = FXHorizontalFrame.new(v_frame, opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y | PACK_UNIFORM_WIDTH, hSpacing: 70)
    @buttons_h_frame = FXHorizontalFrame.new(v_frame, opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y | PACK_UNIFORM_WIDTH)
  end

  def init_text
    @text_to_barcode = FXTextField.new(@info_h_frame, 1, width: 300, height: 100)
    @name_of_file = FXTextField.new(@name_h_frame, 1, width: 800, height: 100)

    @text_to_barcode.font = FXFont.new(app, 'Roboto', 16)
    @name_of_file.font = FXFont.new(app, 'Roboto', 16)
  end

  def init_combo_box
    @combo_box = FXComboBox.new(@select_h_frame, 4, width: 200, height: 100)
    @combo_box.font = FXFont.new(app, 'Roboto', 16)
    @combo_box.numVisible = 4
    @combo_box.editable = false
    @combo_box.appendItem('Code-128')
    @combo_box.appendItem('Code-39')
    @combo_box.appendItem('EAN-8')
    @combo_box.appendItem('EAN-13')
  end

  def init_labels
    select_label = FXLabel.new(@select_h_frame, 'Select Barcode Type')
    info_label = FXLabel.new(@info_h_frame, 'Enter Information')
    name_label = FXLabel.new(@name_h_frame, 'Enter File Name')

    select_label.font = FXFont.new(app, 'Roboto', 20)
    info_label.font = FXFont.new(app, 'Roboto', 20)
    name_label.font = FXFont.new(app, 'Roboto', 20)
  end

  def init_button
    @button_generate = FXButton.new(@buttons_h_frame, 'Create Barcode')
    @button_generate.font = FXFont.new(app, 'Roboto', 35)
    @button_generate.padTop = 10
    @button_generate.padBottom = 10
    @button_generate.padLeft = 15
    @button_generate.padRight = 15
    @button_generate.backColor = FXColor::LightGray
    @button_generate.shadowColor = FXColor::DarkGray
  end

  def init_generator
    @generator = BarcodeGenerator.new
  end

  def on_click_button
    @button_generate.connect(SEL_COMMAND) do
      @generator.create_barcode(@combo_box.text, @text_to_barcode.text, @name_of_file.text)
    end
  end
end