// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"

// Load all controllers using webpack's require.context
const context = require.context(".", true, /_controller\.js$/)
context.keys().forEach((path) => {
  const controller = context(path)
  if (typeof controller.default === "function") {
    const name = path.match(/\.\/(.+)_controller\.js$/)[1]
    application.register(name, controller.default)
  }
})
