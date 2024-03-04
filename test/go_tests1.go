package main

import (
	"fmt"
	"sync"
	"time"
)

// Простой тест функции
func add(a, b int) int {
	return a + b
}

// Тест с использованием интерфейса
type Geometry interface {
	area() float64
}

type Rectangle struct {
	width, height float64
}

func (r Rectangle) area() float64 {
	return r.width * r.height
}

// Тест горутины
func printNumbers(wg *sync.WaitGroup) {
	defer wg.Done()
	for i := 0; i < 5; i++ {
		fmt.Println(i)
		time.Sleep(1 * time.Second)
	}
}

func main() {
	// Тест 1: Простое сложение
	fmt.Println("Test 1: Add function:", add(2, 3))

	// Тест 2: Интерфейсы
	var g Geometry = Rectangle{width: 10, height: 5}
	fmt.Println("Test 2: Interface area function:", g.area())

	// Тест 3-7: Горутины
	var wg sync.WaitGroup
	fmt.Println("Test 3-7: Go Routines")
	for i := 0; i < 5; i++ {
		wg.Add(1)
		go printNumbers(&wg)
	}
	wg.Wait()

	// Дополнительные тесты...


}
