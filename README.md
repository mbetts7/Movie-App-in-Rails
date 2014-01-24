Lab 01/22/14
Extend the movie app:

update

implement
destroy

implement
add bootstrap navigation bar

nav bar shall have links to new, edit and home page
add 'search' feature (that's not REST)

Add a new view with a search box (or incorporate into exiting view)
Add search method to movie controller
Make OMDB API call retrieving movies
Add each movie to the movie_db, redirect to home page
Bonus

remove @@movie_db with a true Rails Model 'Movie' (like Plane and Bog). Keep model simple, use just 'title' and 'year' attributes.If you do the bonus, no need to implement update and destroy for @@movie_db