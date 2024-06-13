# About

A mobile application to keep track of multiple board games. 

It's planned to use a structured JSON file that uses a `meta` attribute to dynamically build the board game page.

Example of the JSON file:
```json
{
  "type": "tab",
  "children": [
    {
      "label": "Title",
      "icon": "home",
      "type": "tabContent",
      "content": {
        "type": "verticalContainer",
        "children": [
          {
            "type": "text",
            "label": "Threat Level"
          },
          ...
        ]
      }
    }
  ]
}
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

