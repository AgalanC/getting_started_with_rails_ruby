=begin

Adding "validations" to our model.

The first "validation" declares that a "title" value must be present. Because "title" is a string, this means that the "title" value must contain at least one non-whitespace character.

The second validation declares that a "body" value must also be present. Additionally, it declares that the "body" value must be at least 10 characters long.

*** IMPORTANT *** - Active Record automatically defines "model" attributes, "title" and "body" for our application, for every table column, so no need to declare those attributes in my "model" file.

=end
class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
