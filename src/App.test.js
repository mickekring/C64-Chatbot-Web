import { render, screen } from '@testing-library/react';
import App from './App';

test('renders C64 terminal', () => {
  render(<App />);
  const readyText = screen.getByText(/READY/i);
  expect(readyText).toBeInTheDocument();
});
