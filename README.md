# imdb-sql-data-analysis
## Project Objective
- Design a relational database schema simulating IMDb’s core data operations.
- Write SQL queries to retrieve movie-related insights: top-rated movies, highest-grossing films, most active directors, etc.
- Perform data analysis on genres, languages, revenue trends, and audience ratings.
- Practice advanced SQL techniques including JOINs, GROUP BY, aggregate functions, subqueries, and window functions.

## Dataset used
- <a href="https://github.com/puvvaditeja/imdb-sql-data-analysis/blob/main/imdb_dataset%20.sql">Dataset</a>

## Database Schema
![DATABASE SCHEMA](https://github.com/user-attachments/assets/0ad862c7-12fb-48d8-90ce-9c47ea12b235)

## Questions
- Find the total number of movies released in each year. How does the trend look month-wise?
- Find the unique list of the genres present in the data set?
- Write a SQL query to find those movies, which were released before 2019. Return movie title.
- Write a SQL query to find those actors with the first name 'A' and the last name 'A' and the Movies_id they are known for. Return actor ID.
- Count how many movies each production company has produced
- Find the yongest actor (by Date_Of_Birth)
- Write a SQL query to find when the movie 'Secret Superstar' was released. Return movie release year.
- Which genre had the highest number of movies produced overall?
- What is the average duration of movies in each genre?
- Which are the top 10 movies based on average rating?
- Summarise the ratings table based on the movie counts by median ratings.
- How many movies released in each genre in March 2017 in the USA had more than 1,000 votes?
- Find the movies in each genre that start with the characters ‘The’ and have an average rating > 8.
- count the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
- Who are the top two actors whose movies have a median rating >= 8?
- Who are the top actresses based on a number of Super Hit movies (average rating >8) in the drama genre?
- Find movies with an average rating higher than the overall average rating of all movies
- Find directors who have directed more than 3 movies
- Create stored procedure to Identify all the movies of particular genre
  
## Project Insights
- The number of movies released are decreased gradually from 2017 to 2019
- The most number movies released in jan,may,october
- Netflix production company produced most number of movies
- Secret Superstar movie was released in the year 2017
- Drama genre had the highest number of movies produced overall (4285)
- Drama genre has the highest movie duration
- Kirket,Love in Kilnerry movies are the top movies based on rating
- The most of movies got rating btw 5 and 8
- Mammootty and mohanla are the top actors whose movies have a median rating >= 8
- Andrew Jones director directed 5 films

## Conclusion
This project highlights the power of SQL in analyzing and extracting meaningful insights from a movie database. It reveals trends in genres, directors, revenue patterns, and audience preferences. The project also strengthens skills in relational database design, complex querying, and real-world data analysis relevant to entertainment and media analytics.
