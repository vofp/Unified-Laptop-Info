s = {
    "1 x 24"=>{:data=>["1", "24"], :count=>1, :votes=>0, :sort=>1}, 
    "1366 x 768"=>{:data=>["1366", "768"], :count=>3, :votes=>0, :sort=>1366}, 
    "8 x 2"=>{:data=>["8", "2"], :count=>1, :votes=>0, :sort=>8}, 
    "8 x 9"=>{:data=>["8", "9"], :count=>1, :votes=>0, :sort=>8}, 
    "1 x 4"=>{:data=>["1", "4"], :count=>1, :votes=>0, :sort=>1}, 
    "1 x 1"=>{:data=>["1", "1"], :count=>2, :votes=>0, :sort=>1}, 
    "3 x 0"=>{:data=>["3", "0"], :count=>1, :votes=>0, :sort=>3}, 
    "600 x 525"=>{:data=>["600", "525"], :count=>1, :votes=>0, :sort=>600}, 
    "345 x 345"=>{:data=>["345", "345"], :count=>3, :votes=>0, :sort=>345}, 
    "350 x 650"=>{:data=>["350", "650"], :count=>1, :votes=>0, :sort=>350}, 
    "0 x 23"=>{:data=>["0", "23"], :count=>1, :votes=>0, :sort=>0}, 
    "1 x 500"=>{:data=>["1", "500"], :count=>1, :votes=>0, :sort=>1}}
p s

s = s.delete_if{ |key,data|
    data[:count] == 1
}
p s