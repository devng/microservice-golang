package main

import (
	"fmt"
	"log"
	"net/http"
)

func greeting() string {
	return "Hello World!"
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, greeting())
	})

	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "OK")
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
}
