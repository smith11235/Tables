rails generate scaffold DataSet name:string parameters:string checksum:string source:string
rails generate scaffold Field data_set:references name:string 
rails generate scaffold Record data_set:references
rails generate scaffold Cell record:references field:references string:string	datetime:datetime int:int float:float
