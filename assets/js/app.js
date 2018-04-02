// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "react-phoenix"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import "./socket"
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { Socket } from 'phoenix'
import MessageBox from "./MessageBox"
import MessageList from "./MessageList"

class App extends Component {
  constructor(props) {
    super(props)

    this.state = { messages: [] }
  }

  componentWillMount() {
    const socket = new Socket('/socket', {params: {token: window.userToken}})
    socket.connect()

    this.channel = socket.channel(`messages:${this.props.roomId}`, {})
    console.log('this.props.roomId', this.props.roomId)
    this.channel.join()
      .receive('ok', resp => {
        console.log('resp', resp)
        this.setState({ messages: resp.messages})
      })
      .receive('error', resp => { console.log('Unable to Join', resp) })

    this.channel.on(`messages:${this.props.roomId}:new`, (data) => {
      const newMessages = data.messages
      this.setState({ messages: [...this.state.messages, ...newMessages] })
    })
  }

  onMessageCreate(text) {
    this.channel.push('message:add', { content: text })
  }

  render() {
    return (
      <div>
        <MessageBox onMessageCreate={this.onMessageCreate.bind(this)} />
        <MessageList messages={this.state.messages} />
      </div>
    )
  }
}

window.renderCommentsApp = (target, roomId) => {
  ReactDOM.render(<App roomId={roomId} />, document.getElementById(target))
}
