package main

import (
	"fmt"
	"net"
)

func main() {
	iface, _ := net.Interfaces()

	for _, i := range iface {
		addrs, _ := i.Addrs()
		if addrs != nil {
			fmt.Print(i.Name)
			fmt.Print(": ")
			fmt.Println(addrs[0])
		}
	}
}
