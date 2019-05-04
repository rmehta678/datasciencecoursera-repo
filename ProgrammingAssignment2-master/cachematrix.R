## This file overall contains a pair of functions utilized to calculate the inverse of a
## matrix using a cache. The inverse operation can be expensive for very large matrices
## and therefore this cache system takes advantage of lexical scoping in R. 

## This function creates a matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        matrixInverse <- NULL
        set <- function(y) {
                x <<- y
                matrixInverse <<- NULL
        }
        get <- function() x
        setInverse <- function(solve) matrixInverse <<- solve
        getInverse <- function() matrixInverse
        list(set = set, get = get,
             setInverse = setInverse,
             getInverse = getInverse)
}


## This function computes the inverse of the matrix returned by makeCacheMatrix above;
## if the inverse has already been calculated makeCacheMatrix will return the already
## calculated inverse matrix. 

cacheSolve <- function(x, ...) {
        matrixInverse <- x$getInverse()
        if(!is.null(matrixInverse)) {
                message("getting cached data")
                return(matrixInverse)
        }
        data <- x$get()
        matrixInverse <- solve(data, ...)
        x$setInverse(matrixInverse)
        matrixInverse
}
