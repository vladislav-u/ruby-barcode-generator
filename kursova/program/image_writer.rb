require 'fox16'
require 'barby'
require 'barby/outputter/png_outputter'
include Barby, Fox

class ImageWriter
  def initialize; end

  def write(barcode, filename)
    begin
      File.open("../barcodes/#{check_filename(filename)}.png", 'wb') { |f| f.write barcode.to_png }
      FXMessageBox.information($app, MBOX_OK, 'Success', "Created barcode #{check_filename(filename)}.png")
    rescue StandardError
      FXMessageBox.error($app, MBOX_OK, 'Error!', 'Invalid name of file!')
    end
  end

  private

  def check_filename(filename)
    if filename.empty?
      'output'
    else
      filename
    end
  end
end
