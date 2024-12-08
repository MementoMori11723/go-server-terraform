package main

import (
	"html/template"
	"net/http"
)

type Todo struct {
	Title string
	Done  bool
}

type TodoPageData struct {
	PageTitle string
	Todos     []Todo
}

func main() {
	tmpl := template.Must(template.ParseFiles("pages/layouts.html"))
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := TodoPageData{
			PageTitle: "My Todo List",
			Todos: []Todo{
				{
					Title: "Task - 1",
					Done:  false,
				},
				{
					Title: "Task - 2",
					Done:  true,
				},
				{
					Title: "Task - 3",
					Done:  true,
				},
			},
		}
		tmpl.Execute(w, data)
	})
	http.HandleFunc("/about", func(w http.ResponseWriter, r *http.Request) {
		about := template.Must(template.ParseFiles("pages/about.html"))
		about.Execute(w, nil)
	})
	http.ListenAndServe(":5000", nil)
}
