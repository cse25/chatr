import React, { Component } from 'react'

class MessageBox extends Component {
  constructor(props) {
    super(props)

    this.state = { text: '' }
  }

  onSubmit(event) {
    event.preventDefault()

    this.props.onMessageCreate(this.state.text)
    this.setState({ text: '' })
  }

  render() {
    return (
      <form onSubmit={this.onSubmit.bind(this)}>
        <input
          className="materialize-textarea"
          value={this.state.text}
          onChange={e => this.setState({ text: e.target.value })}
        />
        <button className="btn">Submit</button>
      </form>
    )
  }
}

export default MessageBox
