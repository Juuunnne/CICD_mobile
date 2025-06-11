import React from 'react';
import { render, fireEvent } from '@testing-library/react-native';

// Adjust the import path to where HomeScreen is exported
import HomeScreen from '../app/(tabs)/index';

describe('HomeScreen', () => {
  it('allows adding a new todo item', () => {
    const { getByPlaceholderText, getByText, queryByText } = render(<HomeScreen />);

    const input = getByPlaceholderText('Add a new to-do...');
    fireEvent.changeText(input, 'Buy milk');
    fireEvent.press(getByText('Add'));

    expect(queryByText('Buy milk')).toBeTruthy();
  });
}); 