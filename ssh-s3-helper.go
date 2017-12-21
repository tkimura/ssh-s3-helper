package main

import (
	"io/ioutil"
	"net/http"
	"log"
	"github.com/zieckey/goini"
	"os"
	"regexp"
)


func main() {
	ini := goini.New()
	err := ini.ParseFile("/etc/default/ssh-s3-helper")
	if err != nil {
		log.Fatal(err)
	}
	s3_region, s3_region_ok := ini.Get("s3_region")
	s3_bucket, s3_bucket_ok := ini.Get("s3_bucket")
	s3_prefix, s3_prefix_ok := ini.Get("s3_prefix")

	if len(os.Args) != 2 {
		log.Fatal("usage: "+os.Args[0]+" [user]")
	}

	user := os.Args[1]

	user_re := regexp.MustCompile("^[a-z_][a-z0-9_-]{0,31}$")

	if user_re.MatchString(user) == false {
		log.Fatal("illegal character")
	}

	if s3_region_ok && s3_bucket_ok && s3_prefix_ok {
		sshkey_url := "https://s3-"+s3_region+".amazonaws.com/"+s3_bucket+"/"+s3_prefix+user

		resp, err := http.Get(sshkey_url)
		if err != nil {
			log.Fatal(err)
		}
		defer resp.Body.Close()
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			log.Fatal(err)
		}
		print(string(body))
	}
}
