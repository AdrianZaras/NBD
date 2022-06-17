import riak
myClient = riak.RiakClient(pb_port=8087)
#wrzucenie dokumentu do bazy 
movie = {'name': 'MATRIX', 'gatunek': 'Sci-Fi', 'premiera': "02.04.2006", 'ocena': 7.7}
bucketMovie = myClient.bucket('s17164')
movie1 = bucketMovie.new(movie['name'], data=movie)
movie1.store()
#pobierze go i wypisze
fetchedMovie = bucketMovie.get(movie1.key)
print(f"wrzuci do bazy dokument, pobierze go i wypisze: {fetchedMovie.data}")
#zmodyfikuje go
updateData=fetchedMovie.data
updateData['ocena'] = 9
updateData['gatunek'] = 'Akcja/Sci-Fi'
fetchedMovie.data= updateData
fetchedMovie.store()
#pobierze i wypisze
fetchedMovie = bucketMovie.get(movie1.key)
print(f"zmodyfikuje go, następnie pobierze i wypisze: {fetchedMovie.data}" )
#usunie go
fetchedMovie.delete()
#próba pobrania
fetchedMovie = bucketMovie.get(movie1.key)

