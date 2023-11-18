package main

import (
	"context"

	"github.com/gobwas/ws"
	"github.com/gobwas/ws/wsutil"
)

func main() {
	serverURL := "ws://127.0.0.1:8080/websocket_endpoint"

	conn, _, _, err := ws.Dial(context.Background(), serverURL)
	if err != nil {
		println("dial:", err)
		return
	}
	defer conn.Close()

	// Send a "hello" message
	if err := wsutil.WriteClientText(conn, []byte("hello")); err != nil {
		println("write:", err)
		return
	}

	// Read server's response
	msg, op, err := wsutil.ReadServerData(conn)
	if err != nil {
		println("read:", err)
		return
	}
	if op != ws.OpText {
		println("unexpected message type")
		return
	}
	println(string(msg))
}
