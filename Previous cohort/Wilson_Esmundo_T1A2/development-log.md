## Development Log
---
### 11/11/19  Issue after creating Bird Class<br>
* I was able to pass the parameters to the class instance variable in an array and iterate each element but was showing class object id and not the value of the element. I was using the method shown below works fine it pushing an object element to the array but its empty and doesn't have any value. Later on I found out that im pushing on an empty object because I didn't assign any parameters and was fixed by the code shown below<br>
<br>

```ruby
wilson.update_database(Bird.new) 
```

### Fixed with:<br>
```ruby
lovebird = Bird.new(bird_id_tag, bird_type, bird_mutation,bird_sex, bird_age)
        
wilson.update_database(lovebird)
```
### Iterate Element:<br>
<br>
Since it was already passing a value to the array, my next issue is how to pull out those values.  When I iterate the elements its just showing the object id and later on the value was pulled out when putting a method next to the element as shown in the fixed below.<br>

```ruby
def update_database
    @collection.each do |element|
    puts element
end
```
### Fixed with:<br>

```ruby
def update_database
@collection.each do |element|
puts element.type
puts element.age
puts element.sex
end
```

15/11/19 Control Flow<br>
* Having issue when user inputs an invalid integer or string when deleting an item from an array.<br>
Challenge was to refactor the code and putting those conditions in single if/else statement. Later on found out about the "between?" method and use that in the code as shown below.
<br>
### Fixed by:

``` ruby
user_delete_input = gets.chomp.to_i
        if user_delete_input.between?(1, @collection.length)
            @collection.slice!(user_delete_input.to_i - 1)
        else
            puts "invalid choice"
        end
```


