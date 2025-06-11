module.exports = {
  preset: 'jest-expo',
  setupFilesAfterEnv: ['@testing-library/jest-native/extend-expect'],
  transformIgnorePatterns: [
    'node_modules/(?!(jest-)?@?react-native|@react-native(-community)?|@expo|expo|@expo/vector-icons/.*|react-navigation|@react-navigation/.*)'
  ],
}; 