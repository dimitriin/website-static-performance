package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"sync"
)

var m sync.Map

func main() {
	http.HandleFunc("/content-length", func(writer http.ResponseWriter, request *http.Request) {
		resource := request.URL.Query().Get("resource")

		if len(resource) <= 0 {
			writer.WriteHeader(http.StatusBadRequest)

			log.Println("no resource parameter")

			return
		}

		if v, ok := m.Load(resource); ok {
			_, _ = writer.Write([]byte(fmt.Sprintf(`{"length":%d}`, v.(int64))))

			return
		}

		headResp, err := http.Head(resource)

		if err != nil {
			writer.WriteHeader(http.StatusInternalServerError)

			log.Println("head request error: " + err.Error())

			return
		}

		defer func() {
			_ = headResp.Body.Close()
		}()

		if headResp.ContentLength >= 0 {
			_, _ = writer.Write([]byte(fmt.Sprintf(`{"length":%d}`, headResp.ContentLength)))

			m.Store(resource, headResp.ContentLength)

			return
		}

		getResp, err := http.Get(resource)

		if err != nil {
			writer.WriteHeader(http.StatusInternalServerError)

			log.Println("get request error: " + err.Error())

			return
		}

		defer func() {
			_ = getResp.Body.Close()
		}()

		if getResp.StatusCode != http.StatusOK {
			writer.WriteHeader(http.StatusInternalServerError)

			log.Println("get request status code not 200")

			return
		}

		data, err := ioutil.ReadAll(getResp.Body)

		if err != nil {
			writer.WriteHeader(http.StatusInternalServerError)

			log.Println("read response body error: " + err.Error())

			return
		}

		_, _ = writer.Write([]byte(fmt.Sprintf(`{"length":%d}`, len(data))))

		m.Store(resource, int64(len(data)))
	})

	if err := http.ListenAndServe(":8090", nil); err != nil {
		log.Println("server stopped with error: " + err.Error())
	}
}
