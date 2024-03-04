package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"sync"
	"time"
)

// Тест сетевого программирования
func httpTest(wg *sync.WaitGroup, url string) {
	defer wg.Done()
	response, err := http.Get(url)
	if err != nil {
		fmt.Println("HTTP test failed:", err)
		return
	}
	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("HTTP test passed, response length:", len(body))
}

func waitGroupTest() {
	var wg sync.WaitGroup

		wg.Add(1)
	go httpTest(&wg, "http://example.com")

		wg.Wait()
}

// Тест использования пакета time
func timeTest() {
	start := time.Now()
	time.Sleep(2 * time.Second)
	duration := time.Since(start)
	fmt.Println("Time test: Slept for", duration)
}

func main() {
	waitGroupTest()
	timeTest()

	// Доп тесты
}
