import React, { Component } from 'react'

class MessageList extends Component {
  renderMessages() {
    return this.props.messages.map(message =>
      this.renderMessage(message)
    )
  }

  renderMessage(message) {
    let name = 'Anonymous'
    if (message.user) {
      name = message.user.name
    }

    return (
      <li key={message.id} className="collection-item">
        {name}: {message.content}
      </li>
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
