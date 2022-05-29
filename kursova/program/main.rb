require 'fox16'
require './main_window'
include Fox

$app = FXApp.new
$main_window = Window.new($app)
$app.create
$app.run