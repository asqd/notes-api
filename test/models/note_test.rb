require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test "that note requires content" do
  	note = Note.new

  	assert !note.save
  	assert !note.errors[:title].empty?
  end

  test "that note has title with at least 5 letters" do
  	note = notes(:short)

  	assert !note.save
  	assert !note.errors[:title].empty?
  end

end
