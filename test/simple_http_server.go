package main

import (
	"fmt"
	"net/http"
)

// handler обрабатывает HTTP-запросы к серверу
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello %s\n", r.URL.Path)
}

func main() {
	http.HandleFunc("/", handler)

	fmt.Println("Starting server port 8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}
