import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log("Favorite controller connected")
  }

  toggle(event) {
    event.preventDefault()
    
    const modelId = this.buttonTarget.getAttribute('data-model-id')
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
    
    if (!csrfToken) {
      console.error('CSRF token not found')
      return
    }
    
    fetch(`/models/${modelId}/toggle_favorite`, {
      method: 'POST',
      headers: {
        'Accept': 'text/vnd.turbo-stream.html',
        'X-CSRF-Token': csrfToken
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok')
      }
      return response.text()
    })
    .then(html => {
      // Turbo Stream 응답 처리
      Turbo.renderStreamMessage(html)
    })
    .catch(error => {
      console.error('Error:', error)
      alert('오류가 발생했습니다.')
    })
  }
} 