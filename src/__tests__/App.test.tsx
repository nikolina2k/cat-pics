import '@testing-library/jest-dom'
import { render, fireEvent, waitFor } from '@testing-library/react'
import App from '../App'

test('demo', () => {
  expect(true).toBe(true)
})

test('Renders the main page', () => {
  render(<App />)
  expect(true).toBeTruthy()
})

test('renders App component', () => {
  const { getByText, getByAltText } = render(<App />)

  const initialText = getByText('Do you want to see some cats?') as HTMLElement
  expect(initialText).toBeInTheDocument()

  const yesButton = getByText('Yes') as HTMLElement
  fireEvent.click(yesButton)

  const newText = getByText('ฅ^•ﻌ•^ฅ') as HTMLElement
  expect(newText).toBeInTheDocument()

  const meoMeoButton = getByText('meo meo') as HTMLElement
  fireEvent.click(meoMeoButton)

  const catImage = getByAltText('Cat') as HTMLElement
  waitFor(() => {
    expect(catImage).toBeInTheDocument()
  })
})
