class Experience < ActiveRecord::Base
  ABILITIES = {'C/C++' => 'C/C++',
    'C#' => 'C#',
    'Java' => 'Java',
    'Microsoft Visual Studio' => 'Microsoft Visual Studio',
    'Python' => 'Python',
    'Ruby(on Rails)' => 'Ruby (on Rails)',
    'SQL Queries' => 'SQL Queries',
    'XCode and Interface Builder' => 'XCode and Interface Builder'}

  COMFORT = {"10 - Mastery" => "10",
    "9" => "9",
    "8" => "8",
    "7" => "7",
    "6" => "6",
    "5 - Somewhat Familiar" => "5",
    "4" => "4",
    "3" => "3",
    "2" => "2",
    "1 - Unfamiliar" => "1"}

  belongs_to :user
end
