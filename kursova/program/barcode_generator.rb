require 'fox16'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/code_39'
require 'barby/barcode/ean_8'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'
require './image_writer'
include Barby, Fox

class BarcodeGenerator
  def initialize
    @barcode_types = %w[Code-39 Code-128 EAN-8 EAN-13]
    @writer = ImageWriter.new
  end

  def create_barcode(type, data, filename)
    case type
    when @barcode_types[0]
      begin
        barcode = Code39.new(data)
        @writer.write(barcode, filename)
      rescue StandardError
        FXMessageBox.error($app, MBOX_OK, 'Error!', "Can't create Code-39 from this input")
      end
    when @barcode_types[1]
      begin
        barcode = Code128.new(data)
        @writer.write(barcode, filename)
      rescue StandardError
        FXMessageBox.error($app, MBOX_OK, 'Error!', "Can't create Code-128 from this input")
      end
    when @barcode_types[2]
      begin
        barcode = EAN8.new(data)
        @writer.write(barcode, filename)
      rescue StandardError
        FXMessageBox.error($app, MBOX_OK, 'Error!', "Can't create EAN-8 from this input")
      end
    when @barcode_types[3]
      begin
        barcode = EAN13.new(data)
        @writer.write(barcode, filename)
      rescue StandardError
        FXMessageBox.error($app, MBOX_OK, 'Error!', "Can't create EAN-13 from this input")
      end
    end
  end
end
