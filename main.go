package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Message struct {
	Message string `json:"message"`
}

type User struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type UsersResponse struct {
	Users []User `json:"users"`
}

func main() {
	// Root endpoint
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		response := Message{Message: "Hello"}
		json.NewEncoder(w).Encode(response)
	})

	// Users endpoint
	http.HandleFunc("/users", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		users := []User{
			{ID: 1, Name: "John Doe"},
			{ID: 2, Name: "Jane Smith"},
			{ID: 3, Name: "Bob Johnson"},
		}
		response := UsersResponse{Users: users}
		json.NewEncoder(w).Encode(response)
	})

	// Health check endpoint
	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		response := Message{Message: "OK"}
		json.NewEncoder(w).Encode(response)
	})

	log.Println("Starting server on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
