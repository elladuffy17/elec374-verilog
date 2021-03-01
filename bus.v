/* here we implement the typical bus. we implement the bus using a 32-to-5 encoder and a 32-to-1 mux. note, the mux was created using
a combination of smaller multiplxers. the five select signal inputs for this multiplexer come from our 32-to-5 encoder */

module bus(
  
