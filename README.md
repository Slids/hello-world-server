# Hello-World-Server

This is an example server using protocol buffers
inside of a rest endpoint in Lisp.
We use the (cl-protobufs)[https://github.com/qitab/cl-protobufs]
lisp protocol buffer implemenation and the
(Hunchentoot)[https://github.com/edicl/hunchentoot] lisp
webserver.

The author makes no claim of optimality. Really
one probably shouldn't use bare Hunchentoot but something
like (Caveman)[http://quickdocs.org/caveman/].
Also, some work should be done to have better protocol buffer
support in the client. This is left to the reader.