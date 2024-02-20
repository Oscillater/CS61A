CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes WHERE height > min AND height <= max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT parents.child FROM parents, dogs WHERE dogs.name = parents.parent ORDER BY dogs.height DESC;


-- Filling out this helper table is optional

  
CREATE TABLE siblings AS
  SELECT p1.child AS n1, p2.child AS n2 FROM parents AS p1, parents AS p2 WHERE p1.parent = p2.parent AND p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT n1 || " and " || n2 ||" are " || s1.size || " siblings" FROM siblings, size_of_dogs AS s1,size_of_dogs AS s2 WHERE siblings.n1 = s1.name AND siblings.n2 = s2.name AND s1.size = s2.size;



-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);
  INSERT INTO stacks_helper(dogs, stack_height, last_height, n) SELECT dogs.name, dogs.height, dogs.height, 1 FROM dogs;
  INSERT INTO stacks_helper(dogs, stack_height, last_height, n) SELECT dogs ||", "|| name, stack_height+height,height,2 FROM stacks_helper,dogs WHERE height > last_height;
  INSERT INTO stacks_helper(dogs, stack_height, last_height, n) SELECT dogs ||", "|| name, stack_height+height,height,3 FROM stacks_helper,dogs WHERE height > last_height;
  INSERT INTO stacks_helper(dogs, stack_height, last_height, n) SELECT dogs ||", "|| name, stack_height+height,height,4 FROM stacks_helper,dogs WHERE height > last_height;
-- Add your INSERT INTOs here


CREATE TABLE stacks AS
  SELECT dogs ,stack_height FROM stacks_helper WHERE n=4 AND stack_height >= 170 ORDER BY stack_height;

