import React, { Component } from 'react'

class MessageList extends Component {
  renderMessages() {
    console.log(this.props)
    return this.props.messages.map(message =>
      <li key={message.id} className="collection-item">{message.content}</li>
    )
  }

  render() {
    return (
      <ul className="collection">
        {this.renderMessages()}
      </ul>
    )
  }
}

export default MessageList
