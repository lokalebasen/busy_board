const socketeer = function(url) {
  var ws = new WebSocket(url)

  ws.onopen = (openEvent) => ws.send("all")
  ws.onmessage = (msgEvent) => {
    util.renderPeople(JSON.parse(msgEvent.data))
  }
  ws.onerror = (errEvent) => console.log(err)
}

