package main

import (
	"fmt"
	"os"
	"strings"
	"text/tabwriter"
	"time"
	"github.com/fsouza/go-dockerclient"
	"github.com/docker/go-units"
)

func Short(s string, i int) string {
	s = strings.TrimPrefix(s, "sha256:")
	runes := []rune( s )
	if len( runes ) > i {
		return string( runes[:i] )
	}
	return s
}

func main() {
	endpoint := "unix:///var/run/docker.sock"
	client, _ := docker.NewClient(endpoint)
	w := new(tabwriter.Writer)
	w.Init(os.Stdout, 20, 1, 3, ' ', 0)

	ticker := time.NewTicker(time.Second)
	quit := make(chan bool)

	fmt.Printf("\033[s")
	go func() {
		for {
			select {
			case <- ticker.C:
				conts, _ := client.ListContainers(docker.ListContainersOptions{All: false})
				fmt.Printf("\033[u")
				fmt.Printf("\033[J")
				titles := "CONTAINER ID\tIMAGE\tCOMMAND\tCREATED\tSTATUS\tNAMES\n"
				fmt.Fprintf(w, titles)
				for _, cont := range conts {
					ID := Short(cont.ID, 12)
					img := Short(cont.Image, 12)
					cmd := Short(cont.Command, 14)
					created := units.HumanDuration(time.Now().UTC().Sub(time.Unix(cont.Created, 0)))
					status := Short(cont.Status, 12)
					names := Short(cont.Names[0][1:], 12)
					fmt.Fprintf(w, "%s\t%s\t\"%s\"\t%s ago\t%s\t%s\n", ID, img, cmd, created, status, names)
					w.Flush()
				}

			}

		}
	}()
	<-quit
}
